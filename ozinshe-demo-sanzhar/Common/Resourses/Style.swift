//
//  Style.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.02.2024.
//

import UIKit

@available(iOS 13.0, *)
var isOSThemeLight: Bool {
    return UserDefaults.standard.bool(forKey: "isOSThemeLight")
}

public enum DefaultStyle {

    // MARK: - Main colors
    public enum Colors {
        public static var white: UIColor {
            if isOSThemeLight {
                return UIColor.black // Return black for light theme
            } else {
                return UIColor.white
            }
        }
        public static var label: UIColor {
            if isOSThemeLight {
                return UIColor.black
            } else {
                return UIColor.white
            }
        }
        public static var background: UIColor {
            if isOSThemeLight {
                return UIColor(hex: "E5EBF0")
            } else {
                return UIColor(hex: "111827")
            }
        }
        public static let error = UIColor(hex: "FF402B")
        
        // MARK: - Purple shades
        public static let purple300 = UIColor(hex: "B376F7")
        public static let purple400 = UIColor(hex: "9753F0")
        public static let purple500 = UIColor(hex: "7E2DFC")
        
        // MARK: - Gray shades
        public static var gray200: UIColor {
            if isOSThemeLight {
                return StaticColors.gray800
            } else {
                return StaticColors.gray200
            }
        }
        public static var gray400: UIColor {
            if isOSThemeLight {
                return StaticColors.gray700
            } else {
                return StaticColors.gray400
            }
        }
        public static var gray500: UIColor {
            if isOSThemeLight {
                return StaticColors.gray600
            } else {
                return StaticColors.gray500
            }
        }
        public static var gray600: UIColor {
            if isOSThemeLight {
                return StaticColors.gray500
            } else {
                return StaticColors.gray600
            }
        }
        public static var gray700: UIColor {
            if isOSThemeLight {
                return StaticColors.gray100
            } else {
                return StaticColors.gray700
            }
        }
        public static var gray800: UIColor {
            if isOSThemeLight {
                return StaticColors.gray200
            } else {
                return StaticColors.gray800
            }
        }
    }
    
    // MARK: - Static colors
    public enum StaticColors {
        public static let darkBackground = UIColor(hex: "111827")
        public static let white = UIColor.white
        public static let label = UIColor.white
        
        public static let error = UIColor(hex: "FF402B")
        
        // MARK: - Purple shades
        public static let purple300 = UIColor(hex: "B376F7")
        public static let purple400 = UIColor(hex: "9753F0")
        public static let purple500 = UIColor(hex: "7E2DFC")
        
        // MARK: - Gray shades
        public static let gray100 = UIColor(hex: "F3F4F6")
        public static let gray200 = UIColor(hex: "E5E7EB")
        public static let gray400 = UIColor(hex: "9CA3AF")
        public static let gray500 = UIColor(hex: "6B7280")
        public static let gray600 = UIColor(hex: "4B5563")
        public static let gray700 = UIColor(hex: "374151")
        public static let gray800 = UIColor(hex: "1C2431")
    }
}

public let Style = DefaultStyle.self
