//
//  ContentCategory.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 01.04.2024.
//

import Foundation
import SwiftyJSON

struct ContentCategory {
    
    var id: Int
    var name: String
    var previewURL: URL?
    var isAgeCategory = false
    
    init(id: Int, name: String, previewURL: URL?, isAgeCategory: Bool = false) {
        self.id = id
        self.name = name
        self.previewURL = previewURL
        self.isAgeCategory = isAgeCategory
    }
    
    init?(json: JSON, isAgeCategory: Bool = false) {
        guard let id = json["id"].int,
              let name = json["name"].string else {
            return nil
        }
        let url = json["link"].string ?? "" // Optional value
        self.init(id: id, name: name, previewURL: URL(string: url), isAgeCategory: isAgeCategory)
    }
    
    
}
