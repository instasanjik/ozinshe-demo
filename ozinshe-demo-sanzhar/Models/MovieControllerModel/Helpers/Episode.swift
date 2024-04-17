//
//  Episode.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 17.04.2024.
//

import Foundation
import SwiftyJSON

final class Episode {
    
    var id = 0
    var youtubeID = ""
    var previewLink = ""
    var number = 0
    
    init() { }
    
    init(json: JSON) {
        if let temp = json["id"].int        { self.id = temp }
        if let temp = json["number"].int    { self.number = temp }
        if let temp = json["link"].string   {
            self.previewLink = "https://img.youtube.com/vi/\(temp)/hqdefault.jpg"
            self.youtubeID = temp
        }
    }
    
    
}
