//
//  FavoriteViewController.swift
//  Grip
//
//  Created by 오국원 on 2022/04/21.
//

import UIKit

private let reuseIdentifier = "SearchCell"

class FavoriteViewController: UIViewController {
    
    //MARK: -Propertie
    private let tableView = UITableView()
    static var favoriteMovieForDeduplication = Set<JSON.Search.Movie>()
    static var movies = [JSON.Search.Movie]()
    
    //MARK: -LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        FavoriteViewController.movies = Array(FavoriteViewController.favoriteMovieForDeduplication)
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

//MARK: -TableViewDelegate and DataSource
extension FavoriteViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteViewController.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
        cell.configureCell(with: FavoriteViewController.movies[indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let alert = UIAlertController(title: "", message: "즐겨찾기를 삭제하시겠습니까?", preferredStyle: UIAlertController.Style.alert)
        
        let okAction = UIAlertAction(title: "삭제", style: .default) { action in
            
            FavoriteViewController.favoriteMovieForDeduplication.remove(FavoriteViewController.movies[indexPath.row])
            FavoriteViewController.movies = Array(FavoriteViewController.favoriteMovieForDeduplication)
            tableView.reloadData()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .default)
        
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
}
