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
        label.text = NSLocalizedString("SignIn-Hello", comment: "Сәлем")
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.white
        return label
    }()
    
    lazy var signUpBodyLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("SignIn-Description", comment: "Аккаунтқа кіріңіз")
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
    
    lazy var emailTextFieldView: OZTextFieldView = {
        let textFieldView = OZTextFieldView()
        textFieldView.textField.placeholder = NSLocalizedString("SignIn-YourEmail", comment: "Сіздің email")
        return textFieldView
    }()
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "Password" //localize
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.white
        return label
    }()
    
    lazy var passwordTextField: OZTextField = {
        let textField = OZTextField()
        textField.placeholder = NSLocalizedString("SignIn-YourPassword", comment: "Сіздің құпия сөзіңіз")
        return textField
    }()
    
    lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("SignIn-ForgotPassword", comment: "Құпия сөзді ұмыттыңыз ба?"), for: .normal) // localize
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(Style.Colors.purple300, for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var loginButton: OZButton = {
        let button = OZButton()
        button.setTitle(NSLocalizedString("SignIn-Join", comment: "Кіру"), for: .normal)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    
    override func viewDidLoad() {
        view.backgroundColor = Style.Colors.background
        
        setupBackButton()
        setupSignUpLabel()
        setupSignUpBodyLabel()
        setupFormView()
        setupLoginButton()
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
            make.height.equalTo(224)
        }
        
        setupEmailLabel()
        setupEmailTextField()
        setupPasswordLabel()
        setupPasswordTextField()
        setupForgotPasswordButton()
    }
    
    private func setupEmailLabel() {
        formView.addSubview(emailLabel)
        
        emailLabel.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
    }
    
    private func setupEmailTextField() {
        formView.addSubview(emailTextFieldView)
        
        emailTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview()
        }
        
        emailTextFieldView.textField.configureTextField(icon: "letter")
    }
    
    private func setupPasswordLabel() {
        formView.addSubview(passwordLabel)
        
        passwordLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(emailTextFieldView.snp.bottom).inset(-16)
        }
    }
    
    private func setupPasswordTextField() {
        formView.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview()
        }
        passwordTextField.configureTextField(icon: "password", suffixImageName: "eye")
    }
    
    private func setupForgotPasswordButton() {
        formView.addSubview(forgotPasswordButton)
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).inset(-16)
        }
    }
    
    private func setupLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(formView.snp.bottom).inset(-16)
            make.left.right.equalTo(formView)
        }
    }
    
    
}


// MARK: Targets
extension SignInViewController {
    
    @objc func loginTapped(sender: UIButton!) {
        Logger.log(.action, "Login tapped")
        
        if Int.random(in: 1...2) % 2 == 0 {
            updateEmailError(text: "Lorem ipsum") // localize
        } else {
            updateEmailError(text: nil)
        }
    }
    
    @objc func forgotPasswordTapped(sender: UIButton!) {
        Logger.log(.action, "Forgot password tapped")
    }
    
    @objc func signUpTapped(sender: UIButton!) {
        Logger.log(.action, "Sign Up tapped")
    }
    
    
}


// MARK: Additional functions
extension SignInViewController {
    
    private func updateEmailError(text: String?) {
        emailTextFieldView.updateError(errorText: text)
        
        formView.snp.updateConstraints { make in
            make.height.equalTo(text == nil ? 224 : 256)
        }
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    
}
