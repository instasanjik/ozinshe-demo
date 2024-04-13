//
//  UIView+Extension.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 14.03.2024.
//

import UIKit

/// Extension to UIView providing a method for setting the view's height with optional animation.
extension UIView {
    
    /// Sets the height of the view to the specified value.
    ///
    /// - Parameters:
    ///   - height: The new height for the view.
    ///   - animateTime: The duration of the animation, if animation is desired. If set to nil, changes will be immediate.
    func setHeight(_ height: CGFloat, animateTime: TimeInterval? = nil) {
        if let heightConstraint = self.constraints.first(where: { $0.firstAttribute == .height && $0.relation == .equal }) {
            heightConstraint.constant = height
            
            if let animateTime = animateTime {
                UIView.animate(withDuration: animateTime) {
                    self.superview?.layoutIfNeeded()
                }
            } else {
                self.superview?.layoutIfNeeded()
            }
        }
    }
    
}
