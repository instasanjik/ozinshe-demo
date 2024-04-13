//
//  Date.swift
//  ARnums
//
//  Created by Sanzhar Koshkarbayev on 01.01.2023.
//

import Foundation

extension Date {
    
    /// Returns the current date and time in ISO8601 format.
    ///
    /// - Note: Requires iOS 15.0 and later.
    static var dateTime: String {
        get {
            if #available(iOS 15.0, *) {
                return Date.now.ISO8601Format()
            } else {
                return ""
            }
        }
    }
    
    /// Returns a string representation of the date in short format (yyyy-MM-dd).
    var shortDate: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        return dateFormatter.string(from: self)
    }
    
}
