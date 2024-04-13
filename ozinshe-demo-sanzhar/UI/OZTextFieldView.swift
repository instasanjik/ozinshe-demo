//
//  OZTextFieldView.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 10.03.2024.
//

import UIKit
import SnapKit

final class OZTextFieldView: UIView {
    
    // MARK: - UI Elements
    
    private lazy var textField = OZTextField()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "SPLASH_TEXT" // TODO: localize with backend
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = Style.Colors.error
        return label
    }()
    
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
}


// MARK: - UI Setups

private extension OZTextFieldView {
    
    func setupUI() {
        addSubview(textField)
        
        textField.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(56)
        }
        
        self.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        setupErrorLabel()
    }
    
    
    func setupErrorLabel() {
        self.addSubview(errorLabel)
        
        errorLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(textField.snp.bottom)
            make.height.equalTo(0)
        }
    }
    
    
}


// MARK: - External functions

extension OZTextFieldView {
    
    public func updateError(errorText text: String?) {
        errorLabel.text = text
        if text == nil {
            textField.textFieldState = .normal
            errorLabel.snp.updateConstraints { make in
                make.top.equalTo(textField.snp.bottom)
                make.height.equalTo(0)
            }
            
            self.snp.updateConstraints { make in
                make.height.equalTo(56)
            }
        } else {
            textField.textFieldState = .error
            errorLabel.snp.updateConstraints { make in
                make.top.equalTo(textField.snp.bottom).inset(-16)
                make.height.equalTo(16)
            }
            
            self.snp.updateConstraints { make in
                make.height.equalTo(88)
            }
        }
    }
    
    
}
