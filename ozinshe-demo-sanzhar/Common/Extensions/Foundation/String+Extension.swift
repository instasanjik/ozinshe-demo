//
//  String.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.04.2024.
//

import Foundation

extension String {
    
    func beautifulDateDisplay() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return nil }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd MMMM yyyy"
        return displayFormatter.string(from: date)
    }
    
    
}
