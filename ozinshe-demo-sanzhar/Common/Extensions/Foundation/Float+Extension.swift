//
//  TimeInterval+Extension.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 05.04.2024.
//

import Foundation

extension Float {
    
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
