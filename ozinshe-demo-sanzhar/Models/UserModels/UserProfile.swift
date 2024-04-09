//
//  UserProfile.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 07.04.2024.
//

import Foundation
import SwiftyJSON

class UserProfile {
    
    var id: Int = 0
    var email: String = ""
    var name: String = ""
    var phoneNumber: String = ""
    var birthDate: String = ""
    var language: String = ""
    
    init(id: Int, name: String, phoneNumber: String, birtdayDate: String) {
        self.id = id
        self.name = name
        self.phoneNumber = phoneNumber
        self.birthDate = birtdayDate
    }
    
    init(json: JSON) {
        if let temp = json["id"].int                    { self.id = temp }
        if let temp = json["user"]["email"].string      { self.email = temp }
        if let temp = json["phoneNumber"].string        { self.name = temp }
        if let temp = json["name"].string               { self.name = temp }
        if let temp = json["birtdayDate"].string        { self.birthDate = temp }
        if let temp = json["language"].string           { self.language = temp }
    }
    
    
}
