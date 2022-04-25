//
//  Movie.swift
//  Grip
//
//  Created by 오국원 on 2022/04/22.
//

import Foundation

struct JSON {
    struct Search: Codable {
        
        let results: [Movie]?
        let totalResults: String?
        let response: String
        
        private enum CodingKeys: String, CodingKey {
            case results = "Search"
            case totalResults
            case response = "Response"
        }
        
        struct Movie: Codable {
            let title: String
            let year: String
            let imdbID: String
            let type: String
            let poster: String
      
            private enum CodingKeys: String, CodingKey {
                case title = "Title"
                case year = "Year"
                case imdbID
                case type = "Type"
                case poster = "Poster"
            }
            
        }
    }
    
}

/*
{
"Search": [
{
"Title": String,
"Year": String,
"imdbID": String,
"Type": String,
"Poster": String(URL)
},
...
],
"totalResults": Int, // 검색 결과 전체 개수, 현재까지 받아온 개수와 비교하여 다음 페이지 호출
"Response": Bool
}
 */
