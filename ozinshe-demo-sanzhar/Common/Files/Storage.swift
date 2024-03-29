//
//  Storage.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 29.03.2024.
//

import Foundation

struct Keys {
    static let isUserOpeningAppFirstTime = "isUserOpeningAppFirstTime"
    
    static let accessToken = "accessToken"
    static let email = "email"
    static let password = "password"
    
    static let id = "user_id"
}

public let Storage = UserDefaults.standard
