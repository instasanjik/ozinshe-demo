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
    
    /// Localizes the string using the provided language or the system's current language if not specified.
    ///
    /// - Parameter language: The language code to use for localization (e.g., "en", "fr").
    /// - Returns: The localized string.
    func localized(language: String? = nil) -> String {
        return LanguageManager.localized(key: self)
    }
    
    
}
