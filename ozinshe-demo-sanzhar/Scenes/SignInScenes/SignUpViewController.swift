//
//  SignUpViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 10.03.2024.
//

import UIKit
import SnapKit

class SignUpViewController: UIViewController {
    
    lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("SignUp-SignUp", comment: "Сәлем")
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.white
        return label
    }()
    
    lazy var signUpDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("SignUp-Description", comment: "Аккаунтқа кіріңіз")
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
    
    lazy var confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("SignUp-PasswordAgain", comment: "Құпия сөзді қайталаңыз") //localize
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.white
        return label
    }()
    
    lazy var confirmPasswordTextField: OZTextField = {
        let textField = OZTextField()
        textField.placeholder = NSLocalizedString("SignIn-Password", comment: "Сіздің құпия сөзіңіз")
        return textField
    }()
    
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem ipsum" // TODO: localize with backend
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = Style.Colors.error
        label.textAlignment = .center
        return label
    }()
    
    lazy var signUpButton: OZButton = {
        let button = OZButton()
        button.setTitle(NSLocalizedString("SignUp-SignUp", comment: "Кіру"), for: .normal)
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return button
    }()
    
    lazy var haveAnAccountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = NSLocalizedString("SignUp-DoUHaveAnAccount?", comment: "Аккаунтыныз жоқ па?")
        label.textColor = Style.Colors.white
        return label
    }()
    
    lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = NSLocalizedString("SignUp-Login", comment: "Тіркелу")
        label.textColor = Style.Colors.purple300
        return label
    }()
    
    lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(haveAnAccountLabel)
        stackView.addArrangedSubview(loginLabel)
        
        stackView.axis = .horizontal
        stackView.spacing = 4
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        stackView.addGestureRecognizer(tap)
        
        return stackView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.Colors.background
        
        setupSignUpLabel()
        setupSignUpBodyLabel()
        setupFormView()
        setupErrorLabel()
        setupSignUpButton()
        setupLoginLabels()
    }
    
    
}


// MARK: UI setups

extension SignUpViewController {
    
    private func setupSignUpLabel() {
        view.addSubview(signUpLabel)
        
        signUpLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
    
    private func setupSignUpBodyLabel() {
        view.addSubview(signUpDescriptionLabel)
        
        signUpDescriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(signUpLabel)
            make.top.equalTo(signUpLabel.snp.bottom).inset(-4)
        }
    }
    
    private func setupFormView() {
        view.addSubview(formView)
        
        formView.snp.makeConstraints { make in
            make.left.equalTo(signUpLabel)
            make.right.equalToSuperview().inset(24)
            make.top.equalTo(signUpDescriptionLabel.snp.bottom).inset(-32)
            make.height.equalTo(275)
        }
        
        setupEmailLabel()
        setupEmailTextField()
        setupPasswordLabel()
        setupPasswordTextField()
        setupConfirmPasswordLabel()
        setupConfirmPasswordTextField()
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
    
    private func setupConfirmPasswordLabel() {
        formView.addSubview(confirmPasswordLabel)
        
        confirmPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).inset(-16)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setupConfirmPasswordTextField() {
        formView.addSubview(confirmPasswordTextField)
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview()
        }
        
        confirmPasswordTextField.configureTextField(icon: "password", suffixImageName: "eye")
    }
    
    private func setupErrorLabel() {
        view.addSubview(errorLabel)
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(formView.snp.bottom).inset(0)
            make.left.right.equalTo(formView)
            make.height.equalTo(0)
        }
    }
    
    private func setupSignUpButton() {
        view.addSubview(signUpButton)
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).inset(-40)
            make.left.right.equalTo(formView)
        }
    }
    
    private func setupLoginLabels() {
        view.addSubview(loginStackView)
        
        loginStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpButton.snp.bottom).inset(-24)
        }
    }
    
    
}



// MARK: Targets
extension SignUpViewController {
    
    @objc func loginTapped(sender: UIButton!) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func signUpTapped(sender: UIGestureRecognizer!) {
        Storage.set("test", forKey: Keys.accessToken)
        
        let vc = MainTabBarController()
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}

extension SignUpViewController {
    
    private func updateErrorMessage(message: String?) {
        if message == nil {
            errorLabel.snp.updateConstraints { make in
                make.top.equalTo(formView.snp.bottom).inset(0)
                make.height.equalTo(0)
            }
        } else {
            errorLabel.snp.updateConstraints { make in
                make.top.equalTo(formView.snp.bottom).inset(-32)
                make.height.equalTo(22)
            }
        }
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    
}
