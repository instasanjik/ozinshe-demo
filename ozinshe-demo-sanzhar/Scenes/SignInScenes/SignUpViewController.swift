//
//  SignUpViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 10.03.2024.
//

import UIKit
import SnapKit
import SVProgressHUD

class SignUpViewController: UIViewController {
    
    
    // MARK: - UI Elements
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.text = "SignUp-SignUp".localized()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.white
        return label
    }()
    
    private lazy var signUpDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "SignUp-Description".localized()
        label.font = UIFont.systemFont(ofSize: 16, weight: .regular)
        label.textColor = Style.Colors.gray400
        return label
    }()
    
    private lazy var formView = UIView()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "Email"
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.white
        return label
    }()
    
    private lazy var emailTextFieldView: OZTextFieldView = {
        let textFieldView = OZTextFieldView()
        textFieldView.textField.placeholder = "SignIn-YourEmail".localized()
        return textFieldView
    }()
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "SignIn-YourPassword".localized()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.white
        return label
    }()
    
    private lazy var passwordTextField: OZTextField = {
        let textField = OZTextField()
        textField.placeholder = "SignIn-YourPassword".localized()
        return textField
    }()
    
    private lazy var confirmPasswordLabel: UILabel = {
        let label = UILabel()
        label.text =  "SignUp-PasswordAgain".localized()
        label.font = UIFont.systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.white
        return label
    }()
    
    private lazy var confirmPasswordTextField: OZTextField = {
        let textField = OZTextField()
        textField.placeholder =  "SignIn-Password".localized()
        return textField
    }()
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.text = "SPLASH_TEXT" // TODO: localize with backend
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = Style.Colors.error
        label.textAlignment = .center
        return label
    }()
    
    private lazy var signUpButton: OZButton = {
        let button = OZButton()
        button.setTitle("SignUp-SignUp".localized(), for: .normal)
        button.addTarget(self, action: #selector(signUpTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var haveAnAccountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "SignUp-DoUHaveAnAccount?".localized()
        label.textColor = Style.Colors.white
        return label
    }()
    
    private lazy var loginLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "SignUp-Login".localized()
        label.textColor = Style.Colors.purple300
        return label
    }()
    
    private lazy var loginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(haveAnAccountLabel)
        stackView.addArrangedSubview(loginLabel)
        
        stackView.axis = .horizontal
        stackView.spacing = 4
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(loginTapped))
        stackView.addGestureRecognizer(tap)
        
        return stackView
    }()
    
    private lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboardFromView))
        tap.cancelsTouchesInView = false
        return tap
    }()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    
}


// MARK: - UI setups

private extension SignUpViewController {
    
    func setupUI() {
        view.backgroundColor = Style.Colors.background
        setupGestureRecognizers()
        
        setupSignUpLabel()
        setupSignUpBodyLabel()
        setupFormView()
        setupErrorLabel()
        setupSignUpButton()
        setupLoginLabels()
    }
    
    func setupGestureRecognizers() {
        view.addGestureRecognizer(tap)
    }
    
    func setupSignUpLabel() {
        view.addSubview(signUpLabel)
        
        signUpLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
    
    func setupSignUpBodyLabel() {
        view.addSubview(signUpDescriptionLabel)
        
        signUpDescriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(signUpLabel)
            make.top.equalTo(signUpLabel.snp.bottom).inset(-4)
        }
    }
    
    func setupFormView() {
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
    
    func setupEmailLabel() {
        formView.addSubview(emailLabel)
        
        emailLabel.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
        }
    }
    
    func setupEmailTextField() {
        formView.addSubview(emailTextFieldView)
        
        emailTextFieldView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview()
        }
        
        emailTextFieldView.textField.configureTextField(icon: "letter")
    }
    
    func setupPasswordLabel() {
        formView.addSubview(passwordLabel)
        
        passwordLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(emailTextFieldView.snp.bottom).inset(-16)
        }
    }
    
    func setupPasswordTextField() {
        formView.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview()
        }
        passwordTextField.configureTextField(icon: "password", suffixImageName: "eye")
    }
    
    func setupConfirmPasswordLabel() {
        formView.addSubview(confirmPasswordLabel)
        
        confirmPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).inset(-16)
            make.left.right.equalToSuperview()
        }
    }
    
    func setupConfirmPasswordTextField() {
        formView.addSubview(confirmPasswordTextField)
        
        confirmPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(confirmPasswordLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview()
        }
        
        confirmPasswordTextField.configureTextField(icon: "password", suffixImageName: "eye")
    }
    
    func setupErrorLabel() {
        view.addSubview(errorLabel)
        
        errorLabel.snp.makeConstraints { make in
            make.top.equalTo(formView.snp.bottom).inset(0)
            make.left.right.equalTo(formView)
            make.height.equalTo(0)
        }
    }
    
    func setupSignUpButton() {
        view.addSubview(signUpButton)
        
        signUpButton.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).inset(-40)
            make.left.right.equalTo(formView)
        }
    }
    
    func setupLoginLabels() {
        view.addSubview(loginStackView)
        
        loginStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(signUpButton.snp.bottom).inset(-24)
        }
    }
    
    
}


// MARK: - Targets

private extension SignUpViewController {
    
    @objc func loginTapped(sender: UIButton!) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    @objc func signUpTapped(sender: UIGestureRecognizer!) {
        signUp()
    }
    
    
}


// MARK: - Internal functions

private extension SignUpViewController {
    
    func updateErrorMessage(message: String?) {
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
    
    func signUp() {
        if passwordTextField.text != confirmPasswordTextField.text {
            SVProgressHUD.showError(withStatus: "SignUp-PasswordsAreDifferent".localized())
            return
        }
        
        if let email = emailTextFieldView.textField.text, let password = passwordTextField.text {
            if email != "" && password != "" {
                SVProgressHUD.show()
                AuthService.shared.signUp(email: email, password: password) { [weak self] statusCode in
                    if statusCode == 200 {
                        SVProgressHUD.dismiss { self?.openMainTabbar() }
                    } else if statusCode == 401 {
                        SVProgressHUD.showError(withStatus: "Login-IncorrectLoginOrPassword".localized())
                    } else if statusCode == 400 {
                        SVProgressHUD.showError(withStatus: "\("General-IncorrectFormat".localized()) \n Status code: \(statusCode)")
                    } else {
                        SVProgressHUD.showError(withStatus: "\("General-UnknownError".localized()) \(statusCode)")
                    }
                }
            } else { // Email or password are empty
                SVProgressHUD.showError(withStatus: "SignIn-EmailIsEmpty".localized())
            }
        }
    }
    
    func openMainTabbar() {
        let vc = MainTabBarController()
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}
