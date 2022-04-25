//
//  WebService.swift
//  Grip
//
//  Created by 오국원 on 2022/04/22.
//

import Foundation

class WebService {
    
    private let cache = NSCache<NSString, NSData>()
    
    func getMovies(name:String,page:Int = 1,completion: @escaping (JSON.Search?) -> Void) {

    guard let url = URL(string: "http://www.omdbapi.com/?apikey=92e32667&s=\(name)&page=\(page)") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completion(nil)
                return
            }
            let movies = try? JSONDecoder().decode(JSON.Search.self, from: data)
            movies == nil ? completion(nil) : completion(movies)
        }.resume()
    
    }
    
    func getImage(url:String, completion: @escaping(Data?, Error?) -> Void) {
        let cacheID = NSString(string: url)
        
        if let cachedData = cache.object(forKey: cacheID) {
            completion((cachedData as Data), nil)
        } else {
            if let url = URL(string: url) {
                let session = URLSession(configuration: URLSessionConfiguration.default)
                var request = URLRequest(url: url)
                request.cachePolicy = .returnCacheDataElseLoad
                request.httpMethod = "get"
                session.dataTask(with: request) { (data, response, error) in
                    if let data = data {
                        self.cache.setObject(data as NSData, forKey: cacheID)
                        completion(data, nil)
                    } else {
                        completion(nil, error)
                    }
                    
                }.resume()
            } else {
                completion(nil,NSLocalizedString("유효하지 않은 URL 입니다.", comment: "") as? Error)
            }
        }
    }
    
    
}
