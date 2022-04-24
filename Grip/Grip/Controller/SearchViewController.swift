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
    private let searchBar = UISearchController(searchResultsController: nil)
    private var movies = [JSON.Search.Movie]()
    private let apiCall = WebService()
        
    //MARK: -LifeCycle
    override func viewDidLoad() {
        super .viewDidLoad()
        configure()
    }
    

    
    //MARK: -configure
    func configure() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "검색"
        navigationItem.searchController = searchBar
        navigationItem.hidesSearchBarWhenScrolling = false
        searchBar.searchBar.placeholder = "Grip_iOS_오국원"
        searchBar.searchBar.delegate = self
        configureTableView()
    }
    
    func configureTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 100
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(tableView)
                
        tableView.showHelpLabel(tableView: tableView, withText: "검색 결과가 없습니다.")

    }
    
    
}

//MARK: -dismiss keyboard
extension SearchViewController: UISearchBarDelegate {
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        searchBar.searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.endEditing(true)
        let query = searchBar.text?.replacingOccurrences(of: " ", with: "%20")
        apiCall.getMovies(name: query!) { movie in
            if let movie = movie {
                self.movies.append(contentsOf: movie)
            }
        }
//        movies.removeAll() 잘 배치하도록

        DispatchQueue.main.async {
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
        print(movies.count)
        return movies.count //page1에서만 로딩돼서 다 똑같이 10개 나옴 즉 페이지 신경써서 다시
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
        cell.configureCell(with: movies[indexPath.row])
        return cell
    }
    

}
