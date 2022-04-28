////
////  testClass.swift
////  Grip
////
////  Created by 오국원 on 2022/04/21.
////
//
//import UIKit
//
//private let reuseIdentifier = "SearchCell"
//
//class SearchViewController: UIViewController {
//    
//    //MARK: -Properties
//    var searchTerm:String = ""
//    
//    private let tableView = UITableView()
//    private let searchBar = UISearchBar()
//    private var movieList = [JSON.Search.Movie]()
//    private let apiCall = WebService()
//        
//    //MARK: -LifeCycle
//    override func viewDidLoad() {
//        super .viewDidLoad()
//        configure()
//    }
//    
//
//    
//    //MARK: -configure
//    func configure() {
//        navigationItem.titleView = searchBar
//        searchBar.placeholder = "Grip_iOS_오국원"
//        searchBar.delegate = self
//        title = "검색"
//        showHelpLabel(withText: "검색 결과가 없습니다.")
//        configureTableView()
//    }
//    
//    func configureTableView() {
//        tableView.delegate = self
//        tableView.dataSource = self
//        
//        tableView.register(SearchCell.self, forCellReuseIdentifier: reuseIdentifier)
//        tableView.rowHeight = 60
//        
//        tableView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
//                
//        view.addSubview(tableView)
//    }
//    
//    func showHelpLabel(withText text: String) {
//        let helpLabel = UILabel()
//        helpLabel.frame.size = CGSize.zero
//        helpLabel.font = UIFont.preferredFont(forTextStyle: .callout)
//        helpLabel.textColor = UIColor.lightGray
//        helpLabel.textAlignment = .center
//        helpLabel.text = text
//        helpLabel.sizeToFit()
//        tableView.backgroundView = helpLabel
//    }
//    
//}
//
////MARK: -dismiss keyboard
//extension SearchViewController: UISearchBarDelegate {
//    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
//        searchBar.endEditing(true)
//    }
//    
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchBar.endEditing(true)
//        guard let url = URL(string: "http://www.omdbapi.com/?apikey=92e32667&s=\(searchBar.text!)") else {
//            fatalError("잘못된 URL입니다.")
//        }
//        var request = URLRequest(url: url)
//        request.httpMethod = "GET"
//        
//        URLSession.shared.dataTask(with: request) { (data, response, error) in
//            guard let data = data else { return }
//            do {
//                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { return }
//                if statusCode == 200 {
//                    let finaldata = try JSONDecoder().decode(JSON.Search.self, from: data)
//                    self.movieList = finaldata.results!
//                }
//            } catch {
//                print(error)
//            }
//            print(self.movieList)
//        }.resume()
//        
//    }
//}
//
////MARK: -TableCell
//extension SearchViewController: UITableViewDelegate, UITableViewDataSource {
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        if section == 0 {
//            return 0
//        }
//        return movieList.count
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! SearchCell
//        return cell
//    }
//    
//
//}
