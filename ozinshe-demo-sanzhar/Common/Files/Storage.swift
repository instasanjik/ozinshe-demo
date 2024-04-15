//
//  Storage.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 29.03.2024.
//

import Foundation

class Storage {
    public var accessToken: String = ""
    
    public var isFirstTime: Bool = false
    
    static let sharedInstance = Storage()
}

