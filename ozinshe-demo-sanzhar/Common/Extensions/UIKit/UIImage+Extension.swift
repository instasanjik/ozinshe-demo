//
//  UIImage+Extension.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 05.04.2024.
//

import UIKit

extension UIImage {
    
    static func circle(diameter: CGFloat, color: UIColor) -> UIImage {
        let size = CGSize(width: diameter, height: diameter)
        let rect = CGRect(origin: .zero, size: size)
        
        UIGraphicsBeginImageContextWithOptions(size, false, 0)
        defer { UIGraphicsEndImageContext() }
        
        guard let context = UIGraphicsGetCurrentContext() else { return UIImage() }
        context.setFillColor(color.cgColor)
        context.fillEllipse(in: rect)
        
        guard let image = UIGraphicsGetImageFromCurrentImageContext()?.withRenderingMode(.alwaysOriginal) else { return UIImage() }
        return image
    }
    
    
}
