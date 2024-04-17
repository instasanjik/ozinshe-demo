//
//  UILabel+Extension.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 15.03.2024.
//

import UIKit

extension UILabel {
    
    /// Returns the number of lines currently rendered in the label.
    var countLabelLines: Int {
        let text = self.text! as NSString
        let attributes = [NSAttributedString.Key.font : self.font]
        
        let labelSize = text.boundingRect(with: CGSize(width: self.bounds.width, height: CGFloat.greatestFiniteMagnitude), options: NSStringDrawingOptions.usesLineFragmentOrigin, attributes: attributes as [NSAttributedString.Key : Any], context: nil)
        return Int(ceil(CGFloat(labelSize.height) / self.font.lineHeight))
    }
    
    /// Returns a Boolean value indicating whether the label's text is truncated.
    var isTruncated: Bool {
        guard numberOfLines > 0 else { return false }
        return countLabelLines > numberOfLines
    }
    
    
}
