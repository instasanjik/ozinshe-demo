//
//  AgeAndGenreCardContent.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 01.04.2024.
//

import Foundation
import SwiftyJSON

struct AgeAndGenreCardContent {
    
    var id: Int = 0
    var name: String = ""
    var link: String = ""
    
    init(json: JSON) {
        if let temp = json["id"].int        { self.id = temp }
        if let temp = json["name"].string   { self.name = temp }
        if let temp = json["link"].string   { self.link = temp }
    }
    
    
}
