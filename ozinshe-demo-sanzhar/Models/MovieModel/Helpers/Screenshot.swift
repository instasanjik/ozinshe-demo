//
//  Screenshot.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 01.04.2024.
//

import Foundation
import SwiftyJSON

final class Screenshot {
    
    var id: Int
    var imageURL: URL?
    
    init(id: Int, imageURL: URL?) {
        self.id = id
        self.imageURL = imageURL
    }
    
    convenience init?(json: JSON) {
        guard let id = json["id"].int,
              let url = json["link"].string else {
            return nil
        }
        self.init(id: id, imageURL: URL(string: url))
    }
    
    
}
