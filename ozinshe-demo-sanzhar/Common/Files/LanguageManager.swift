//
//  LanguageManager.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 15.04.2024.
//

import UIKit


final class OZLanguage {
    
    let displayName: String
    let systemCode: String
    
    init(displayName: String, systemCode: String) {
        self.displayName = displayName
        self.systemCode = systemCode
    }
    
    
}


final class OZLanguageManager {
    
    private var currentLanguageCode: String = ""
    
    let languages: [OZLanguage] = [
        OZLanguage(displayName: "Қазақша", systemCode: "kk"),
        OZLanguage(displayName: "Русский", systemCode: "ru"),
        OZLanguage(displayName: "English", systemCode: "en")
    ]
    
    var currentLanguageDisplayName: String {
        for language in languages {
            if #available(iOS 16, *) {
                if Locale.current.language.languageCode?.identifier == language.systemCode {
                    return language.displayName
                }
            } else {
                if Locale.current.languageCode == language.systemCode {
                    return language.displayName
                }
            }
        }
        return "English"
    }
    
    var currentLanguageSystemCode: String {
        if #available(iOS 16, *) {
            return Locale.current.language.languageCode?.identifier ?? "en"
        } else {
            return Locale.current.languageCode ?? "en"
        }
    }
    
    
}


extension OZLanguageManager {
    
    func changeLanguage(to: OZLanguage) {
        
        NotificationCenter.default.post(name: Notification.Name("OZLanguageChanged"), object: nil)
    }
    
    
}


let LanguageManager = OZLanguageManager()
