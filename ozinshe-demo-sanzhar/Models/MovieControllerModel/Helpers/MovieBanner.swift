//
//  MoviePoster.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 01.04.2024.
//

import Foundation
import SwiftyJSON

struct MovieBanner {
    
    var id = 0
    var link = ""
    var movie = MovieWithDetails()
    
    init() {}
    
    init(json: JSON) {
        if let temp = json["id"].int        { self.id = temp }
        if let temp = json["link"].string   { self.link = temp }
        
        if json["movie"].exists() {
            movie = MovieWithDetails(json: json["movie"])
        }
    }
    
    
}
