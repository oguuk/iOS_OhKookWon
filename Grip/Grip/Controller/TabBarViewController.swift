//
//  TabBarViewController.swift
//  Grip
//
//  Created by 오국원 on 2022/04/21.
//

import UIKit

class TabBarViewController:UITabBarController {
    
    //MARK: -Properties
    let searchVC = UINavigationController(rootViewController: SearchViewController())
    let favoriteVC = UINavigationController(rootViewController: FavoriteViewController())
    
    //MARK: -Lifecycle
    override func viewDidLoad() {
        super .viewDidLoad()
        configure()
    }
    
    //MARK: - configure
    func configure() {
        self.setViewControllers([searchVC,favoriteVC], animated: true)
        guard let items = self.tabBar.items else {return}
        
        searchVC.title = "검색"
        favoriteVC.title = "즐겨찾기"
        
        items[0].image = UIImage(systemName: "magnifyingglass")
        items[1].image = UIImage(systemName: "star.fill")
        
        
    }
}

