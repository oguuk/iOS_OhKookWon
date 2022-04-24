//
//  FavoriteViewController.swift
//  Grip
//
//  Created by 오국원 on 2022/04/21.
//

import UIKit

private let reuseIdentifier = "SearchCell"

class FavoriteViewController: UIViewController {
    //MARK: -Properties
    private let tableView = UITableView()

    //MARK: -LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
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
        tableView.rowHeight = 100
        
        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
        view.addSubview(tableView)
        
        tableView.showHelpLabel(tableView: tableView, withText: "목록이 비어있습니다.")
    }
}

//MARK: -Table

extension FavoriteViewController: UITableViewDelegate,UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 20
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
        return cell
    }
    
    
}
