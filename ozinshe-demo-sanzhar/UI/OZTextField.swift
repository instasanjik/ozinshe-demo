//
//  OZTextField.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.02.2024.
//

import UIKit
import SnapKit

class OZTextField: UITextField {
    
    enum OZTextFieldState {
        case normal
        case error
    }
    
    var normalBorderColor = Style.Colors.gray400.cgColor
    var focusedBorderColor = Style.Colors.purple400.cgColor
    var errorBorderColor = Style.Colors.error.cgColor
    
    var textFieldState: OZTextFieldState = .normal {
        didSet {
            layer.borderColor =  textFieldState == .error ? errorBorderColor : normalBorderColor
        }
    }
    
    var padding = UIEdgeInsets(top: 0, left: 44, bottom: 0, right: 44)
    
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
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.error
        return label
    }()
    
    lazy var suffixButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(toggleHidingMode), for: .touchUpInside)
        return button
    }()
    
    
    convenience init() {
        self.init(frame: .zero)
        
        font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        
        attributedPlaceholder = NSAttributedString(
                string: "DEFAULT",
                attributes: [.foregroundColor: Style.Colors.gray400,
                             .font: UIFont.systemFont(ofSize: 16, weight: .regular)]
        )
        
        backgroundColor = Style.Colors.gray700
        
        layer.cornerRadius = 12
        layer.borderWidth = 1
        layer.borderColor = normalBorderColor
        
        textColor = Style.Colors.white
        
        layer.masksToBounds = true
    }
    
    
    func configureTextField(icon imageName: String, suffixImageName: String? = nil) {
        addSubview(iconImageView)
        
        iconImageView.image = UIImage(named: imageName)
        
        iconImageView.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(18)
            make.left.equalToSuperview().inset(16)
            make.width.equalTo(iconImageView)
        }
        
        addSubview(errorLabel)
        
        errorLabel.snp.updateConstraints { make in
            make.top.equalTo(self.snp.bottom).inset(-24)
            make.left.right.equalToSuperview()
            make.height.equalTo(24)
        }
        
        if let suffixImageName = suffixImageName {
            addSubview(suffixButton)
            
            suffixButton.snp.makeConstraints { make in
                make.top.bottom.right.equalToSuperview().inset(16)
                make.height.equalTo(suffixButton.snp.width)
            }
            
            suffixButton.setImage(UIImage(named: suffixImageName), for: .normal)
            
            isSecureTextEntry = suffixImageName == "eye"
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


extension OZTextField {
    
    @objc func toggleHidingMode(sender: UIButton!) {
        isSecureTextEntry.toggle()
        let imageName = isSecureTextEntry ? "eye" : "eye-outlined"
        suffixButton.setImage(UIImage(named: imageName), for: .normal)
    }
    
    
}
