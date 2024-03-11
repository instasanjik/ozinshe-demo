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
    
    lazy var helloLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("SignIn-Hello", comment: "Сәлем")
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.white
        return label
    }()
    
    lazy var helloDescriptionLabel: UILabel = {
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
        label.text = NSLocalizedString("SignIn-YourPassword", comment: "Сіздің құпия сөзіңіз")
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
        button.setTitle(NSLocalizedString("SignIn-ForgotPassword", comment: "Құпия сөзді ұмыттыңыз ба?"), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(Style.Colors.purple300, for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var loginButton: OZButton = {
        let button = OZButton()
        button.setTitle(NSLocalizedString("SignIn-Join", comment: "Кіру"), for: .normal)
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var haveNoAccountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = NSLocalizedString("SignIn-HaveNoAccount", comment: "Аккаунтыныз жоқ па?")
        label.textColor = Style.Colors.white
        return label
    }()
    
    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = NSLocalizedString("SignIn-SignUp", comment: "Тіркелу")
        label.textColor = Style.Colors.purple300
        return label
    }()
    
    lazy var signUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(haveNoAccountLabel)
        stackView.addArrangedSubview(signUpLabel)
        
        stackView.axis = .horizontal
        stackView.spacing = 4
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(signUpTapped))
        stackView.addGestureRecognizer(tap)
        
        return stackView
    }()
    
    lazy var googleSignInButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitle(NSLocalizedString("SignIn-Google", comment: "Google-мен тіркеліңіз"), for: .normal)
        button.setImage(UIImage(named: "google-logo"), for: .normal)
        
        button.backgroundColor = Style.Colors.gray600
        
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        
        button.centerTextAndImage(spacing: 10)
        
        button.addTarget(self, action: #selector(signUpWithGoogleTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var appleSignInButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitle(NSLocalizedString("SignIn-AppleID", comment: "Apple ID-мен тіркеліңіз"), for: .normal)
        button.setImage(UIImage(named: "apple-logo"), for: .normal)
        
        button.backgroundColor = Style.Colors.gray600
        
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        
        button.centerTextAndImage(spacing: 10)
        
        button.addTarget(self, action: #selector(signUpWithAppleTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var orLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = NSLocalizedString("SignIn-or", comment: "Немесе")
        label.textColor = Style.Colors.gray400
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.Colors.background
        
        setupBackButton()
        setupSignUpLabel()
        setupSignUpBodyLabel()
        setupFormView()
        setupLoginButton()
        setupSignUpLabels()
        setupGoogleButton()
        setupAppleButton()
        setupOrLabel()
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
        view.addSubview(helloLabel)
        
        helloLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(backButton.snp.bottom).inset(-24)
        }
    }
    
    private func setupSignUpBodyLabel() {
        view.addSubview(helloDescriptionLabel)
        
        helloDescriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(helloLabel)
            make.top.equalTo(helloLabel.snp.bottom).inset(-4)
        }
    }
    
    private func setupFormView() {
        view.addSubview(formView)
        
        formView.snp.makeConstraints { make in
            make.left.equalTo(helloLabel)
            make.right.equalToSuperview().inset(24)
            make.top.equalTo(helloDescriptionLabel.snp.bottom).inset(-32)
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
            make.right.equalToSuperview()
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
    
    private func setupSignUpLabels() {
        view.addSubview(signUpStackView)
        
        signUpStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).inset(-16)
        }
    }
    
    private func setupGoogleButton() {
        view.addSubview(googleSignInButton)
        
        googleSignInButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(12)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(52)
        }
    }
    
    private func setupAppleButton() {
        view.addSubview(appleSignInButton)
        
        appleSignInButton.snp.makeConstraints { make in
            make.bottom.equalTo(googleSignInButton.snp.top).inset(-8)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(52)
        }
    }
    
    private func setupOrLabel() {
        view.addSubview(orLabel)
        
        orLabel.snp.makeConstraints { make in
            make.bottom.equalTo(appleSignInButton.snp.top).inset(-16)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(18)
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
    
    @objc func signUpTapped(sender: UIGestureRecognizer!) {
        Logger.log(.action, "Sign Up tapped")
    }
    
    @objc func signUpWithAppleTapped(sender: UIButton!) {
        Logger.log(.action, "Sign Up With Apple tapped")
    }
    
    @objc func signUpWithGoogleTapped(sender: UIButton!) {
        Logger.log(.action, "Sign Up With Google tapped")
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
