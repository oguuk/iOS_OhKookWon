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
    //    static var favoriteMovieForDeduplication = Set<JSON.Search.Movie>()
    static var movies = [JSON.Search.Movie]()
    
    //MARK: -LifeCycle
    override func viewWillAppear(_ animated: Bool) {
        //        FavoriteViewController.movies = Array(FavoriteViewController.favoriteMovieForDeduplication)
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
        
        self.tableView.dragInteractionEnabled = true
        self.tableView.dragDelegate = self
        
        tableView.register(SearchCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 120
        tableView.separatorStyle = .none

        
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

//MARK: - TableViewDelegate and DataSource
extension FavoriteViewController: UITableViewDelegate,UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return FavoriteViewController.movies.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
        cell.separatorInset = UIEdgeInsets.zero
        
        cell.configureCell(with: FavoriteViewController.movies[indexPath.row],image: "")
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        cellClickedAndAlert("즐겨찾기를 삭제하시겠습니까?", indexPath.row, action: {
            FavoriteViewController.movies.remove(at: indexPath.row)
            tableView.reloadData()
            //            FavoriteViewController.favoriteMovieForDeduplication.remove(FavoriteViewController.movies[indexPath.row])
            //            FavoriteViewController.movies = Array(FavoriteViewController.favoriteMovieForDeduplication)
        })
    }
}


//MARK: - Drag and Drop
extension FavoriteViewController: UITableViewDragDelegate {
    
    func tableView(_ tableView: UITableView, itemsForBeginning session: UIDragSession, at indexPath: IndexPath) -> [UIDragItem] {
        return [UIDragItem(itemProvider: NSItemProvider())]
    }
    
    func tableView(_ tableView: UITableView, dropSessionDidUpdate session: UIDropSession, withDestinationIndexPath destinationIndexPath: IndexPath?) -> UITableViewDropProposal {
        if session.localDragSession != nil {
            return UITableViewDropProposal(operation: .move, intent: .insertAtDestinationIndexPath)
        }
        return UITableViewDropProposal(operation: .cancel, intent: .unspecified)
    }
    
    func tableView(_ tableView: UITableView, performDropWith coordinator: UITableViewDropCoordinator) { }
    
    //MARK: - Row Editable true
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    //MARK: - Move Row Instance Method
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let moveCell = FavoriteViewController.movies[sourceIndexPath.row]
        FavoriteViewController.movies.remove(at: sourceIndexPath.row)
        FavoriteViewController.movies.insert(moveCell, at: destinationIndexPath.row)
    }
}
