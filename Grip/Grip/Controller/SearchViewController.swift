//
//  SearchViewController.swift
//  Grip
//
//  Created by 오국원 on 2022/04/21.
//

import UIKit

private let reuseIdentifier = "SearchCell"

class SearchViewController: UIViewController {
    
    //MARK: -Properties
    private let tableView = UITableView()
    private var searchPage = (nextPage: 1, batchCount: 0, totalResults: 0)
    private let searchBar = UISearchController(searchResultsController: nil)
    private var movies = [JSON.Search.Movie]()
    private let apiCall = WebService()
    private var movieName = ""
    private var totalPage = 0
    private var nextPage = 1
    private var scrollDirection = ScrollDirection.up
    
    //MARK: -LifeCycle
    override func viewDidLoad() {
        super .viewDidLoad()
        configure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }
    
    //MARK: -configure
    func configure() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "검색"
        navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBar.searchBar.placeholder = "Grip_iOS_오국원"
        searchBar.searchBar.delegate = self
        searchBar.obscuresBackgroundDuringPresentation = false
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 120
        tableView.separatorStyle = .none
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(tableView)
        
        tableView.showHelpLabel(tableView: tableView, withText: "검색 결과가 없습니다.")
    }
    
}

//MARK: -dismiss keyboard
extension SearchViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        DispatchQueue.main.async {
            self.movies.removeAll()
            self.tableView.showHelpLabel(tableView: self.tableView, withText: "검색 결과가 없습니다.")
            self.tableView.reloadData()
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.obscuresBackgroundDuringPresentation = false
        
        if let visibleRow = self.tableView.visibleCells.last {
            if totalPage > 10 {
                
                if scrollDirection == .down {
                    
                    self.totalPage -= 10
                    self.nextPage += 1
                    apiCall.getMovies(name: self.movieName,page: self.nextPage) { movie in
                        if let movie = movie {
                            self.movies.append(contentsOf: movie.results!)
                            DispatchQueue.main.async {
                                self.tableView.reloadData()
                            }
                        }
                    }
                }
            } else {
                self.totalPage = 0
                self.nextPage = 1
            }
        }
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        let query = searchBar.text!.replacingOccurrences(of: " ", with: "%20")
        self.movieName = query
        self.nextPage = 1
        apiCall.getMovies(name: movieName) { movie in
            if let movie = movie {
                if let totalResults = movie.totalResults {
                    self.totalPage = Int(totalResults)!
                    self.movies = movie.results!
                    DispatchQueue.main.async {
                        self.tableView.backgroundView = UIView()
                        self.tableView.reloadData()
                    }
                } else {
                    self.dispatchQueueRemoveAllAndReloadData()
                }
                
            } else {
                self.dispatchQueueRemoveAllAndReloadData()
            }
        }
    }
    
    //MARK: -Helper Function
    func dispatchQueueRemoveAllAndReloadData() {
        DispatchQueue.main.async {
            self.movies.removeAll()
            self.tableView.showHelpLabel(tableView: self.tableView, withText: "검색 결과가 없습니다.")
            self.tableView.reloadData()
        }
    }
}

//MARK: -TableCell
extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movies.count //page1에서만 로딩돼서 다 똑같이 10개 나옴 즉 페이지 신경써서 다시
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
        
        if FavoriteViewController.movies.contains(movies[indexPath.row]) {
            cell.configureCell(with: movies[indexPath.row],image: "bookmark.fill")
        } else {
            cell.configureCell(with: movies[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as? SearchCell
        
        if FavoriteViewController.movies.contains(movies[indexPath.row]) {
            
            cellClickedAndAlert("삭제하시겠습니까?", indexPath.row, action:{
                FavoriteViewController.movies.remove(at: indexPath.row)
                cell!.configureCell(with: self.movies[indexPath.row],image: "bookmark")
                tableView.reloadData()
            })
            
        } else {
            
            cellClickedAndAlert("추가하시겠습니까?", indexPath.row, action:{
                FavoriteViewController.movies.append(self.movies[indexPath.row])
                cell!.configureCell(with: self.movies[indexPath.row],image: "bookmark.fill")
                tableView.reloadData()
            })
        }
    }
}

//MARK: - UIScrollView
extension SearchViewController {
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        if velocity.y >= 0 {
            scrollDirection = .down
        } else {
            scrollDirection = .up
        }
    }
}


////MARK: - UISearchResultsUpdating
//extension SearchViewController: UISearchResultsUpdating {
//    func updateSearchResults(for searchController: UISearchController) {
//        print("movie")
//        if let searchTerm = searchBar.searchBar.text {
//            guard searchTerm.count > 2 else { return }
//            self.movieName = searchTerm
//            apiCall.getMovies(name: movieName) { movie in
//                if let movie = movie {
//                    if let totalResults = movie.totalResults {
//                        self.totalPage = Int(totalResults)!
//                        self.movies = movie.results!
//                        DispatchQueue.main.async {
//                            self.tableView.backgroundView = UIView()
//                            self.tableView.reloadData()
//                        }
//                    } else {
//                        DispatchQueue.main.async {
//                            self.movies.removeAll()
//                            self.tableView.showHelpLabel(tableView: self.tableView, withText: "검색 결과가 없습니다.")
//                            self.tableView.reloadData()
//                        }
//                    }
//
//                } else {
//                    DispatchQueue.main.async {
//                        self.movies.removeAll()
//                        self.tableView.showHelpLabel(tableView: self.tableView, withText: "검색 결과가 없습니다.")
//                        self.tableView.reloadData()
//                    }
//                }
//            }
//        }
//    }
//
//
//}
