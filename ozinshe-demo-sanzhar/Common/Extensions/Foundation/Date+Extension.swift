//
//  Date+Extension.swift
//  ARnums
//
//  Created by Sanzhar Koshkarbayev on 01.01.2023.
//

import Foundation

extension Date {
    
    /// Geiing date time from date object
    static var dateTime: String {
        get {
            if #available(iOS 15.0, *) {
                return Date.now.ISO8601Format()
            } else {
                return ""
            }
        }
    }
    
    
}
