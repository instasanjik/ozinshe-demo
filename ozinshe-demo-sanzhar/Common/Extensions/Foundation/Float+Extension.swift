//
//  TimeInterval+Extension.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 05.04.2024.
//

import Foundation

extension Float {
    
    /// Returns a formatted string representing the time interval.
    ///
    /// - Returns: A string representing the time interval in the format "HH:mm:ss" if hours are present, otherwise "mm:ss".
    var timeCodeValue: String {
        let hours = Int(self) / 3600
        let minutes = (Int(self) % 3600) / 60
        let seconds = Int(self) % 60
        
        if hours > 0 {
            return String(format: "%02d:%02d:%02d", hours, minutes, seconds)
        } else {
            return String(format: "%02d:%02d", minutes, seconds)
        }
    }
    
    
}

