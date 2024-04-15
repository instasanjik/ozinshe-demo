//
//  SignInViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.02.2024.
//

import UIKit
import SnapKit
import SVProgressHUD

class SignInViewController: UIViewController {
    
    // - MARK: UI Elemets
    
    private lazy var helloLabel: UILabel = {
        let label = UILabel()
        label.text = "SignIn-Hello".localized()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.white
        return label
    }()
    
    private lazy var helloDescriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "SignIn-Description".localized()
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
    
    private lazy var forgotPasswordButton: UIButton = {
        let button = UIButton()
        button.setTitle("SignIn-ForgotPassword".localized(), for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        button.setTitleColor(Style.Colors.purple300, for: .normal)
        button.contentHorizontalAlignment = .right
        button.addTarget(self, action: #selector(forgotPasswordTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var loginButton: OZButton = {
        let button = OZButton()
        button.setTitle("SignIn-Join".localized(), for: .normal)
        button.addTarget(self, action: #selector(loginTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var haveNoAccountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "SignIn-HaveNoAccount".localized()
        label.textColor = Style.Colors.white
        return label
    }()
    
    private lazy var signUpLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.text = "SignIn-SignUp".localized()
        label.textColor = Style.Colors.purple300
        return label
    }()
    
    private lazy var signUpStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.addArrangedSubview(haveNoAccountLabel)
        stackView.addArrangedSubview(signUpLabel)
        
        stackView.axis = .horizontal
        stackView.spacing = 4
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(signUpTapped))
        stackView.addGestureRecognizer(tap)
        
        return stackView
    }()
    
    private lazy var googleSignInButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitle("SignIn-Google".localized(), for: .normal)
        button.setImage(UIImage(named: "google-logo"), for: .normal)
        
        button.backgroundColor = Style.Colors.gray600
        
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        
        button.centerTextAndImage(spacing: 10)
        
        button.addTarget(self, action: #selector(signUpWithGoogleTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var appleSignInButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitle("SignIn-AppleID".localized(), for: .normal)
        button.setImage(UIImage(named: "apple-logo"), for: .normal)
        
        button.backgroundColor = Style.Colors.gray600
        
        button.layer.cornerRadius = 12
        button.layer.masksToBounds = true
        
        button.centerTextAndImage(spacing: 10)
        
        button.addTarget(self, action: #selector(signUpWithAppleTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var orLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.text = "SignIn-or".localized()
        label.textColor = Style.Colors.gray400
        return label
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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
}


// MARK: - UI setups

private extension SignInViewController {
    
    func setupUI() {
        view.backgroundColor = Style.Colors.background
        setupGestureRecognizers()
        
        setupSignUpLabel()
        setupSignUpBodyLabel()
        setupFormView()
        setupLoginButton()
        setupSignUpLabels()
        setupGoogleButton()
        setupAppleButton()
        setupOrLabel()
    }
    
    func setupGestureRecognizers() {
        view.addGestureRecognizer(tap)
    }
    
    func setupSignUpLabel() {
        view.addSubview(helloLabel)
        
        helloLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
    
    func setupSignUpBodyLabel() {
        view.addSubview(helloDescriptionLabel)
        
        helloDescriptionLabel.snp.makeConstraints { make in
            make.left.equalTo(helloLabel)
            make.top.equalTo(helloLabel.snp.bottom).inset(-4)
        }
    }
    
    func setupFormView() {
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
    
    func setupForgotPasswordButton() {
        formView.addSubview(forgotPasswordButton)
        
        forgotPasswordButton.snp.makeConstraints { make in
            make.right.equalToSuperview()
            make.top.equalTo(passwordTextField.snp.bottom).inset(-16)
        }
    }
    
    func setupLoginButton() {
        view.addSubview(loginButton)
        
        loginButton.snp.makeConstraints { make in
            make.top.equalTo(formView.snp.bottom).inset(-16)
            make.left.right.equalTo(formView)
        }
    }
    
    func setupSignUpLabels() {
        view.addSubview(signUpStackView)
        
        signUpStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(loginButton.snp.bottom).inset(-16)
        }
    }
    
    func setupGoogleButton() {
        view.addSubview(googleSignInButton)
        
        googleSignInButton.snp.makeConstraints { make in
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(12)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(52)
        }
    }
    
    func setupAppleButton() {
        view.addSubview(appleSignInButton)
        
        appleSignInButton.snp.makeConstraints { make in
            make.bottom.equalTo(googleSignInButton.snp.top).inset(-8)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(52)
        }
    }
    
    func setupOrLabel() {
        view.addSubview(orLabel)
        
        orLabel.snp.makeConstraints { make in
            make.bottom.equalTo(appleSignInButton.snp.top).inset(-16)
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(18)
        }
    }
    
    
}


// MARK: - Targets

private extension SignInViewController {
    
    @objc func loginTapped(sender: UIButton!) {
        signIn()
    }
    
    @objc func forgotPasswordTapped(sender: UIButton!) {
        openForgotPassword()
    }
    
    @objc func signUpTapped(sender: UIGestureRecognizer!) {
        openSignUp()
    }
    
    @objc func signUpWithAppleTapped(sender: UIButton!) {
        SVProgressHUD.showError(withStatus: "General-FunctionUnavailableError".localized())
    }
    
    @objc func signUpWithGoogleTapped(sender: UIButton!) {
        SVProgressHUD.showError(withStatus: "General-FunctionUnavailableError".localized())
    }
    
    
}


// MARK: - Internal functions

private extension SignInViewController {
    
    func updateEmailError(text: String?) {
        emailTextFieldView.updateError(errorText: text)
        
        formView.snp.updateConstraints { make in
            make.height.equalTo(text == nil ? 224 : 256)
        }
        
        UIView.animate(withDuration: 0.1) {
            self.view.layoutIfNeeded()
        }
    }
    
    func signIn() {
        if let email = emailTextFieldView.textField.text, let password = passwordTextField.text {
            if email != "" && password != "" {
                SVProgressHUD.show()
                AuthService.shared.login(email: email, password: password) { statusCode in
                    if statusCode == 200 {
                        SVProgressHUD.dismiss { self.openMainTabbar() }
                    } else if statusCode == 401 {
                        SVProgressHUD.showError(withStatus: "Login-IncorrectLoginOrPassword".localized())
                    } else {
                        SVProgressHUD.showError(withStatus: "General-UnknownError".localized())
                    }
                }
            } else { // MARK: email or password are empty
                SVProgressHUD.showError(withStatus: "SignIn-EmailIsEmpty".localized())
            }
        }
    }
    
    func openMainTabbar() {
        let vc = MainTabBarController()
        vc.modalTransitionStyle = .flipHorizontal
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true)
    }
    
    func openForgotPassword() {
        SVProgressHUD.showError(withStatus: "General-FunctionUnavailableError".localized())
    }
    
    func openSignUp() {
        let vc = SignUpViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}
