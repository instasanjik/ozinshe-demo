//
//  Season.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 01.04.2024.
//

import Foundation
import SwiftyJSON

struct Season {
    
    var id = 0
    var movieId = 0
    var number = 0
    var videos: [Episode] = []
    
    init(json: JSON) {
        if let temp = json["id"].int        { self.id = temp }
        if let temp = json["movieId"].int   { self.movieId = temp }
        if let temp = json["number"].int    { self.number = temp }
        
        if let array = json["videos"].array {
            for item in array {
                let video = Episode(json: item)
                videos.append(video)
            }
        }
    }
    
    
}
