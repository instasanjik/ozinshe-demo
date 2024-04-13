//
//  UIButton.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 10.03.2024.
//

import UIKit

/// Extension to UIButton providing utility functions for manipulating text, image, and background color.
extension UIButton {
    
    /// Centers the button's text and image with the specified spacing.
    ///
    /// - Parameter spacing: The amount of spacing between the text and image.
    func centerTextAndImage(spacing: CGFloat) {
        let insetAmount = spacing / 2
        let writingDirection = UIApplication.shared.userInterfaceLayoutDirection
        let factor: CGFloat = writingDirection == .leftToRight ? 1 : -1
        
        self.imageEdgeInsets = UIEdgeInsets(top: 0, left: -insetAmount*factor, bottom: 0, right: insetAmount*factor)
        self.titleEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount*factor, bottom: 0, right: -insetAmount*factor)
        self.contentEdgeInsets = UIEdgeInsets(top: 0, left: insetAmount, bottom: 0, right: insetAmount)
    }
    
    /// Changes the button's background color to the specified color with animation.
    ///
    /// - Parameters:
    ///   - animationDuration: The duration of the animation.
    ///   - toColor: The color to which the background should change.
    func changeBackgroundWithAnimation(animationDuration: TimeInterval = 10, toColor: UIColor) {
        let cornerRadius = self.layer.cornerRadius
        
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [toColor.cgColor, self.backgroundColor?.cgColor ?? UIColor.clear.cgColor]
        gradientLayer.locations = [0.0, 0.0]
        gradientLayer.frame = self.bounds
        gradientLayer.cornerRadius = cornerRadius
        
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.5)
        gradientLayer.endPoint = CGPoint(x: 1.0, y: 0.5)
        
        self.layer.insertSublayer(gradientLayer, at: 0)
        
        let animation = CABasicAnimation(keyPath: "locations")
        animation.fromValue = [0.0, 0.0]
        animation.toValue = [1.0, 1.0]
        animation.duration = animationDuration
        animation.timingFunction = CAMediaTimingFunction(name: .linear)
        gradientLayer.add(animation, forKey: "gradientAnimation")
        
        self.backgroundColor = nil
    }
    
    /// Stops any ongoing background animation and restores the background color of the button.
    ///
    /// - Parameter backgroundColor: The color to set as the background color.
    func stopBackgroundAnimation(backgroundColor: UIColor) {
        self.layer.sublayers?.removeAll { $0 is CAGradientLayer }
        self.backgroundColor = backgroundColor
    }
    
}
