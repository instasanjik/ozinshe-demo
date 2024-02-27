//
//  ColorPalette.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.02.2024.
//

import UIKit

public enum DefaultStyle {

    public enum Colors {

        public static let label: UIColor = {
            return .white
        }()
        
        public static let background: UIColor = {
            return UIColor(hex: "111827")
        }()
        
        public static let purple300: UIColor = {
            return UIColor(hex: "B376F7")
        }()
        
        public static let purple500: UIColor = {
            return UIColor(hex: "7E2DFC")
        }()
        
        public static let gray400: UIColor = {
            return UIColor(hex: "9CA3AF")
        }()
        
        public static let gray600: UIColor = {
            return UIColor(hex: "4B5563")
        }()
        
        
    }
    
    
}

public let Style = DefaultStyle.self
