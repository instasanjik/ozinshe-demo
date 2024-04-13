//
//  UIColor.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.02.2024.
//

import UIKit

/// Extension to UIColor providing convenience initializer for creating UIColor from hexadecimal string.
extension UIColor {
    
    /// Initializes a UIColor instance with a hexadecimal string.
    ///
    /// - Parameter hexString: The hexadecimal string representing the color.
    ///                         Can be either RGB (6 characters), ARGB (8 characters), or short RGB (3 characters) format.
    ///                         Case-insensitive. Can optionally include a leading '#'.
    /// - Returns: A UIColor instance representing the color specified by the hexadecimal string.
    ///
    /// - Note: If the hexadecimal string is invalid, the initializer defaults to black color.
    convenience init(hex hexString: String) {
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt64()
        Scanner(string: hex).scanHexInt64(&int)
        let a, r, g, b: UInt64
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
}
