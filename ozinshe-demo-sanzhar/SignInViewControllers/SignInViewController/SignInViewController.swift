//
//  SignInViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.02.2024.
//

import UIKit
import SnapKit

class SignInViewController: UIViewController {
    
    lazy var backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = Style.Colors.white
        return button
    }()
    
    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "Sign Up"
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.white
        return label
    }()
    
    lazy var signUpBodyLabel: UILabel = {
        let label = UILabel()
        label.text = "Log in to your account"
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = Style.Colors.gray400
        return label
    }()
    
    lazy var formView = UIView()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.white
        return label
    }()
    
    lazy var emailTextField: OZTextField = {
        let textField = OZTextField()
        return textField
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.white
        return label
    }()
    
    
    
    
    override func viewDidLoad() {
        view.backgroundColor = Style.Colors.background
        
        setupBackButton()
        setupSignUpLabel()
        setupSignUpBodyLabel()
        setupFormView()
    }
    
    
}


// MARK: UI setups
extension SignInViewController {
    
    private func setupBackButton() {
        view.addSubview(backButton)
        
        backButton.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            make.width.height.equalTo(40)
        }
    }
    
    private func setupSignUpLabel() {
        view.addSubview(signUpLabel)
        
        signUpLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(backButton.snp.bottom).inset(-24)
        }
    }
    
    private func setupSignUpBodyLabel() {
        view.addSubview(signUpBodyLabel)
        
        signUpBodyLabel.snp.makeConstraints { make in
            make.left.equalTo(signUpLabel)
            make.top.equalTo(signUpLabel.snp.bottom)
        }
    }
    
    private func setupFormView() {
        view.addSubview(formView)
        
        formView.snp.makeConstraints { make in
            make.left.equalTo(signUpLabel)
            make.right.equalToSuperview().inset(24)
            make.top.equalTo(signUpBodyLabel.snp.bottom).inset(-32)
            make.height.equalTo(200)
        }
        
        setupEmailLabel()
        setupEmailTextField()
    }
    
    private func setupEmailLabel() {
        formView.addSubview(emailLabel)
        
        emailLabel.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
    }
    
    private func setupEmailTextField() {
        formView.addSubview(emailTextField)
        
        emailTextField.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).inset(-4)
            make.left.right.equalToSuperview()
            make.height.equalTo(56)
        }
        emailTextField.reloadBorder()
    }
    
    
}

extension SignInViewController {
    
}
