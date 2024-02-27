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
        
        public static let purple: UIColor = {
            return UIColor(hex: "7E2DFC")
        }()
        
        public static let gray400: UIColor = {
            return UIColor(hex: "9CA3AF")
        }()
        
        
    }
    
    
}

public let Style = DefaultStyle.self
