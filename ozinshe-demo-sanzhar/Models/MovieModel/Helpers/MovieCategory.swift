//
//  MovieCategory.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 06.04.2024.
//

import Foundation
import SwiftyJSON

struct MovieCategory {
    
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
    
    init?(json: JSON) {
        guard let id = json["id"].int,
              let name = json["name"].string else {
            return nil
        }
        self.init(id: id, name: name)
    }
    
    
}
