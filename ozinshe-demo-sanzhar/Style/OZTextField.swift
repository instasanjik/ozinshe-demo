//
//  OZTextField.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.02.2024.
//

import UIKit

class OZTextField: UITextField {
    
    var padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 16);
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    
    convenience init() {
        self.init(frame: .zero)
        backgroundColor = Style.Colors.gray700
        layer.cornerRadius = 12

        layer.masksToBounds = true
    }
    
    public func reloadBorder() {
        layer.borderWidth = 1
        layer.borderColor = UIColor.red.cgColor
    }
    
}
