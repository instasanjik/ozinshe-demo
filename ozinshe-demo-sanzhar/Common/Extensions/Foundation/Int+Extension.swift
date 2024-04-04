//
//  Int+Extension.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 05.04.2024.
//

import Foundation

extension Int {
    
    func ordinalString() -> String {
        let number = self
        let languageCode: String?
        if #available(iOS 16, *) {
            languageCode = Locale.current.language.languageCode?.identifier
        } else {
            languageCode = Locale.current.languageCode
        }
        
        switch languageCode {
        case "ru":
            let mod10 = number % 10
            let mod100 = number % 100
            if mod10 == 1 && mod100 != 11 {
                return "\(number)й"
            } else if mod10 >= 2 && mod10 <= 4 && (mod100 < 10 || mod100 >= 20) {
                return "\(number)й"
            } else {
                return "\(number)й"
            }
        case "en":
            switch number {
            case 1:
                return "\(number)st"
            case 2:
                return "\(number)nd"
            case 3:
                return "\(number)rd"
            default:
                return "\(number)th"
            }
        case "kz":
            return "\(number)-ші"
        default:
            return "\(number)"
        }
    }
    
    
}
