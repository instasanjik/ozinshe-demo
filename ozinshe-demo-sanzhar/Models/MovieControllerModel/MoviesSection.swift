//
//  MovieControllerModel.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 01.04.2024.
//

import Foundation
import SwiftyJSON

struct MoviesSection {
    
    var categoryId = 0
    var categoryName = ""
    var movies: [MovieWithDetails] = []
    
    init() {}
    
    init(json: JSON) {
        if let temp = json["categoryId"].int        { self.categoryId = temp }
        if let temp = json["categoryName"].string   { self.categoryName = temp }
        
        if let array = json["movies"].array {
            for item in array {
                let temp = MovieWithDetails(json: item)
                self.movies.append(temp)
            }
        }
    }
    
    
}
