//
//  OZTextField.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.02.2024.
//

import UIKit
import SnapKit

class OZTextField: UITextField {
    
    let normalBorderColor = Style.Colors.gray400.cgColor
    let focusedBorderColor = Style.Colors.purple400.cgColor
    let errorBorderColor = Style.Colors.error.cgColor
    
    var padding = UIEdgeInsets(top: 0, left: 40, bottom: 0, right: 16)
    
    override func textRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func placeholderRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    override func editingRect(forBounds bounds: CGRect) -> CGRect {
        return bounds.inset(by: padding)
    }
    
    lazy var iconImageView = UIImageView()
    
    
    
    convenience init() {
        self.init(frame: .zero)
        backgroundColor = Style.Colors.gray700
        
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = Style.Colors.gray400.cgColor
        
        textColor = Style.Colors.white
        font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        layer.masksToBounds = true
    }
    
    func configureTextField(icon imageName: String) {
        addSubview(iconImageView)
        
        iconImageView.image = UIImage(named: imageName)
        
        iconImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(18)
            make.left.equalToSuperview().inset(16)
            make.width.equalTo(iconImageView)
        }
    }
    
    
}


extension OZTextField {
    
    override func becomeFirstResponder() -> Bool {
        layer.borderColor = focusedBorderColor
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        layer.borderColor = normalBorderColor
        return super.resignFirstResponder()
    }
    
    
}
