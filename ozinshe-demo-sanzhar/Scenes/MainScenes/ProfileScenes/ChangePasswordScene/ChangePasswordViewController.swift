//
//  ChangePasswordViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 29.03.2024.
//

import UIKit
import SnapKit
import SVProgressHUD

class ChangePasswordViewController: UIViewController {
    
    // MARK: - UI Elements
    
    private lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.label
        label.text = "ChangePassword-NewPassword".localized()
        return label
    }()
    
    private lazy var passwordTextField: OZTextField = {
        let textField = OZTextField()
        textField.placeholder = "SignIn-YourPassword".localized()
        textField.configureTextField(icon: "password", suffixImageName: "eye")
        return textField
    }()
    
    private lazy var passwordConfirmationLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.label
        label.text = "ChangePassword-RepeatPassword".localized()
        return label
    }()
    
    private lazy var passwordConfirmationTextField: OZTextField = {
        let textField = OZTextField()
        textField.placeholder = "SignIn-YourPassword".localized()
        textField.configureTextField(icon: "password", suffixImageName: "eye")
        return textField
    }()
    
    private lazy var saveButton: OZButton = {
        let button = OZButton()
        button.titleText = "Save"
        button.addTarget(self, action: #selector(saveButtonTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        addKeyboardObservers()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setTabBarHidden(false)
    }
    
    
}


// MARK: - UI Setups

private extension ChangePasswordViewController {
    
    func setupUI() {
        view.backgroundColor = Style.Colors.background
        setupNavigationBar()
        
        setupPasswordLabel()
        setupPasswordTextField()
        
        setupPasswordConfirmationLabel()
        setupPasswordConfirmationTextField()
        
        setupSaveButton()
    }
    
    func setupNavigationBar() {
        navigationItem.title = "Profile-ChangePassword".localized()
    }
    
    func setupPasswordLabel() {
        view.addSubview(passwordLabel)
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.left.equalToSuperview().inset(24)
        }
    }
    
    func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    
    func setupPasswordConfirmationLabel() {
        view.addSubview(passwordConfirmationLabel)
        
        passwordConfirmationLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).inset(-24)
            make.left.equalToSuperview().inset(24)
        }
    }
    
    func setupPasswordConfirmationTextField() {
        view.addSubview(passwordConfirmationTextField)
        
        passwordConfirmationTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordConfirmationLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    
    func setupSaveButton() {
        view.addSubview(saveButton)
        
        saveButton.snp.makeConstraints { make in
            make.left.bottom.right.equalTo(view.safeAreaLayoutGuide).inset(24)
        }
    }
    
    
}


// MARK: - Internal functions

private extension ChangePasswordViewController {
    
    func addKeyboardObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardDidShow), name: UIWindow.keyboardDidShowNotification, object: nil)
    }
    
    
}


// MARK: - Targets

private extension ChangePasswordViewController {
    
    @objc func saveButtonTapped() {
        let password = passwordTextField.text ?? ""
        let passwordConfirmation = passwordConfirmationTextField.text ?? ""
        
        if password != passwordConfirmation {
            SVProgressHUD.showError(withStatus: "Passwords are not similar!")
            return
        } else if password.isEmpty {
            SVProgressHUD.showError(withStatus: "Password can not be empty")
            return
        }
        
        SVProgressHUD.show()
        CoreService.shared.changeUserPassword(password: password) { success, errorMessage in
            if success {
                DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                    SVProgressHUD.showSuccess(withStatus: "New password saved successfully!")
                    self.navigationController?.popToRootViewController(animated: true)
                }
            } else {
                SVProgressHUD.showError(withStatus: "Something went wrong. please, try again later")
            }
        }
    }
    
    @objc func keyboardDidShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if view.frame.origin.y == 0 {
                let height = keyboardSize.height
                self.saveButton.snp.updateConstraints { make in
                    make.bottom.equalTo(view.safeAreaLayoutGuide).inset(height)
                }
            }
        }
    }
    
    
}
