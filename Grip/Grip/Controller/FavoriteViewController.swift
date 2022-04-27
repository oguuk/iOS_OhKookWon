//
//  FavoriteViewController.swift
//  Grip
//
//  Created by 오국원 on 2022/04/21.
//

import UIKit

//protocol favoriteList {
//    var favoriteList:Set<Dictionary<String, String>> { get set }
//}

private let reuseIdentifier = "SearchCell"

class FavoriteViewController: UIViewController {
    //MARK: -Propertie
    static var favoriteMovieForDeduplication = Set<Dictionary<String,String>>()
    private var favoriteMovieForList = [Dictionary<String,String>]()
    private let tableView = UITableView()
    static var movies = [JSON.Search.Movie]()
    var loadedFavoriteMovieIndex = 0
    
    //MARK: -LifeCycle
    override func viewWillAppear(_ animated: Bool) {
//        for movie in FavoriteViewController.favoriteMovieForDeduplication {
//            favoriteMovieForList.append(movie)
//        }
        configure()
    }
    
    //MARK: -configure
    func configure() {
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "내 즐겨찾기"
        TableConfigure()
    }
    
    func TableConfigure() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 120
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(tableView)
        
        if FavoriteViewController.movies.count == 0 {
            self.tableView.showHelpLabel(tableView: self.tableView, withText: "목록이 비어있습니다.")
        } else {
            DispatchQueue.main.async {
                self.tableView.backgroundView = UIView()
                self.tableView.reloadData()
            }
        }
        
    }
    
}

//MARK: -Table
extension FavoriteViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteViewController.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
        cell.configureCell(with: FavoriteViewController.movies[indexPath.row])
//        let movieIndexPathRow = favoriteMovieForList[loadedFavoriteMovieIndex]
//        cell.configureCell(with: JSON.Search.Movie.init(title: movieIndexPathRow["title"]!, year:movieIndexPathRow["year"]!, imdbID: movieIndexPathRow["imdbID"]!, type: movieIndexPathRow["type"]!, poster: movieIndexPathRow["poster"]!))
//        if loadedFavoriteMovieIndex < favoriteMovieForList.count - 1 {
//            loadedFavoriteMovieIndex += 1
//        }
        return cell
    }
    

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "", message: "즐겨찾기를 삭제하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        let okAction = UIAlertAction(title: "삭제", style: .default) { action in
            FavoriteViewController.movies.remove(at: indexPath.row)
            tableView.reloadData()
        }
        let cancelAction = UIAlertAction(title: "취소", style: .default) { action in
            
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        present(alert, animated: false, completion: nil)
    }
    

    
    
}
