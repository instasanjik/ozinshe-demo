//
//  String.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.04.2024.
//

import Foundation

extension String {
    
    /// Converts the string representation of a date into a beautiful display format.
    ///
    /// - Returns: A string representing the date in a beautiful display format ("dd MMMM yyyy").
    func beautifulDateDisplay() -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let date = dateFormatter.date(from: self) else { return nil }
        
        let displayFormatter = DateFormatter()
        displayFormatter.dateFormat = "dd MMMM yyyy"
        return displayFormatter.string(from: date)
    }
    
    func localized(language: String? = nil) -> String {
        let key = self
        let language = language ?? Locale.preferredLanguages.first?.components(separatedBy: "-").first ?? "en"
        guard let path = Bundle.main.path(forResource: language, ofType: "lproj"), let bundle = Bundle(path: path) else {
            return Bundle.main.localizedString(forKey: key, value: nil, table: nil)
        }
        return bundle.localizedString(forKey: key, value: nil, table: nil)
    }
    
    
    
}
