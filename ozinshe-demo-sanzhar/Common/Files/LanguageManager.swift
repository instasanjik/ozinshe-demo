//
//  LanguageManager.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 15.04.2024.
//

import UIKit
import SwiftyJSON


final class OZLanguage {
    
    let displayName: String
    let systemCode: String
    
    init(displayName: String, systemCode: String) {
        self.displayName = displayName
        self.systemCode = systemCode
    }
    
    
}


final class OZLanguageManager {
    
    let languages: [OZLanguage] = [
        OZLanguage(displayName: "Қазақша", systemCode: "kk"),
        OZLanguage(displayName: "Русский", systemCode: "ru"),
        OZLanguage(displayName: "English", systemCode: "en")
    ]
    
    var appleCurrentLanguageCode: String {
        return UserDefaults.standard.array(forKey: "AppleLanguages")?.first as? String ?? ""
    }
    
    var currentLanguageDisplayName: String {
        for language in languages {
            if #available(iOS 16, *) {
                if appleCurrentLanguageCode == language.systemCode {
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
            return appleCurrentLanguageCode
        } else {
            return Locale.current.languageCode ?? "en"
        }
    }
    
    var localizedJSON: JSON? = nil
    
    var LocalizedFile: JSON {
        if let localizedJSON = localizedJSON {
            return localizedJSON
        } else {
            if let path = Bundle.main.path(forResource: "LocalizableJSON", ofType: "json") {
                do {
                    let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                    let json = try JSON(data: data)
                    localizedJSON = json
                    return json
                } catch _ {
                    return JSON()
                }
            } else {
                return JSON()
            }
        }
    }
    
    var localizationQueue: DispatchGroup = DispatchGroup()
    
    
}


extension OZLanguageManager {
    
    func changeLanguage(to language: OZLanguage) {
        UserDefaults.standard.set([language.systemCode], forKey: "AppleLanguages")
        NotificationCenter.default.post(name: Notification.Name("OZLanguageChanged"), object: nil)
    }
    
    func localized(key: String) -> String {
        return LanguageManager.LocalizedFile["strings"][key][currentLanguageSystemCode].stringValue
    }
    
    
}


let LanguageManager = OZLanguageManager()
