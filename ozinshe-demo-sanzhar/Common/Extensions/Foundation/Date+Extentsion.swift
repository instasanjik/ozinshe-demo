//
//  Date.swift
//  ARnums
//
//  Created by Sanzhar Koshkarbayev on 01.01.2023.
//

import Foundation

extension Date {
    
    static var dateTime: String {
        get {
            if #available(iOS 15.0, *) {
                return Date.now.ISO8601Format()
            } else {
                return ""
            }
        }
    }
    
    var shortDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
    
}
