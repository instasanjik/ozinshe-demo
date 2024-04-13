//
//  Style.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.02.2024.
//

import UIKit

public enum DefaultStyle {

    // MARK: - Main colors
    public enum Colors {
        public static let white = UIColor.white
        public static let label = UIColor.white
        public static let background = UIColor(hex: "111827")
        public static let error = UIColor(hex: "FF402B")
        
        // MARK: - Purple shades
        public static let purple300 = UIColor(hex: "B376F7")
        public static let purple400 = UIColor(hex: "9753F0")
        public static let purple500 = UIColor(hex: "7E2DFC")
        
        // MARK: - Gray shades
        public static let gray200 = UIColor(hex: "E5E7EB")
        public static let gray400 = UIColor(hex: "9CA3AF")
        public static let gray500 = UIColor(hex: "6B7280")
        public static let gray600 = UIColor(hex: "4B5563")
        public static let gray700 = UIColor(hex: "374151")
        public static let gray800 = UIColor(hex: "1C2431")
    }
    
    // MARK: - Static colors
    public enum StaticColors {
        public static let darkBackground = UIColor(hex: "111827")
        public static let white = UIColor.white
        public static let label = UIColor.white
        public static let gray400 = UIColor(hex: "9CA3AF")
        public static let purple300 = UIColor(hex: "B376F7")
        public static let purple500 = UIColor(hex: "7E2DFC")
    }
}

public let Style = DefaultStyle.self
