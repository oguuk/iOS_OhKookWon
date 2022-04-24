//
//  WebService.swift
//  Grip
//
//  Created by 오국원 on 2022/04/22.
//

import Foundation

class WebService {
    func getMovies(name:String,page:Int = 1,completion: @escaping (([JSON.Search.Movie]?) -> Void)) {

    guard let url = URL(string: "http://www.omdbapi.com/?apikey=92e32667&s=\(name)&page=\(page)") else {
        fatalError("잘못된 URL입니다.")
    }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let movies = try? JSONDecoder().decode(JSON.Search.self, from: data)
            movies == nil ? completion(nil) : completion(movies?.results)
        }.resume()
    
    }
    
    
}
