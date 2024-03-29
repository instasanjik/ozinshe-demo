//
//  OZExpandedView.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 29.03.2024.
//

import UIKit

class OZExpandedView: UIView {
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        if !self.clipsToBounds && !self.isHidden && self.alpha > 0.0 {
            let subviews = self.subviews.reversed()
            for member in subviews {
                let subPoint = member.convert(point, from: self)
                if let result: UIView = member.hitTest(subPoint, with:event) {
                    return result
                }
            }
        }
        return super.hitTest(point, with: event)
    }
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        return super.point(inside: point, with: event)
    }
    
    
}
