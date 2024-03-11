//
//  ColorPalette.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.02.2024.
//

import UIKit

public enum DefaultStyle {

    public enum Colors {
        
        public static let white: UIColor = {
            return .white
        }()

        public static let label: UIColor = {
            return .white
        }()
        
        
        public static let background: UIColor = {
            return UIColor(hex: "111827")
        }()
        
        
        public static let purple300: UIColor = {
            return UIColor(hex: "B376F7")
        }()
        
        public static let purple400: UIColor = {
            return UIColor(hex: "9753F0")
        }()
        
        public static let purple500: UIColor = {
            return UIColor(hex: "7E2DFC")
        }()
        
        
        public static let gray400: UIColor = {
            return UIColor(hex: "9CA3AF")
        }()
        
        public static let gray500: UIColor = {
            return UIColor(hex: "6B7280")
        }()
        
        public static let gray600: UIColor = {
            return UIColor(hex: "4B5563")
        }()
        
        public static let gray700: UIColor = {
            return UIColor(hex: "374151")
        }()
        
        public static let gray800: UIColor = {
            return UIColor(hex: "1C2431")
        }()
        
        
        public static let error: UIColor = {
            return UIColor(hex: "FF402B")
        }()
        
        
    }
    
    
}

public let Style = DefaultStyle.self
