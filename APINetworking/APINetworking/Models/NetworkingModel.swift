//
//  NetworkingModel.swift
//  APINetworking
//
//  Created by Consultant on 12/29/22.
//

import Foundation
import Alamofire

class NetworkingModel {
    
    var films:Films?
    
    func loadData(fileName: String) {
        let request = Alamofire.request(fileName)
        request.responseJSON { response in
            
            let data = response.data
            do {
                let decoder = JSONDecoder()
                let jsonData = try decoder.decode(Films.self, from: data!)
                self.films = jsonData
                print(self.films)
            } catch {
                print("error:\(error)")
            }
        }
    }
}


struct Film: Decodable {
  let id: Int
  let title: String
  let openingCrawl: String
  let director: String
  let producer: String
  let releaseDate: String
  let starships: [String]
  
  enum CodingKeys: String, CodingKey {
    case id = "episode_id"
    case title
    case openingCrawl = "opening_crawl"
    case director
    case producer
    case releaseDate = "release_date"
    case starships
  }
}

struct Films: Decodable {
  let count: Int
  let all: [Film]
  
  enum CodingKeys: String, CodingKey {
    case count
    case all = "results"
  }
}
