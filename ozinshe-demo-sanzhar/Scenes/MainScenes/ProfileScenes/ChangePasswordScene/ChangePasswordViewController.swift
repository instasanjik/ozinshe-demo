//
//  ChangePasswordViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 29.03.2024.
//

import UIKit
import SnapKit

class ChangePasswordViewController: UIViewController {
    
    lazy var passwordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.label
        label.text = NSLocalizedString("ChangePassword-NewPassword", comment: "Құпия сөз")
        return label
    }()
    
    lazy var passwordTextField: OZTextField = {
        let textField = OZTextField()
        textField.placeholder = NSLocalizedString("SignIn-YourPassword", comment: "Сіздің құпия сөзіңіз")
        textField.configureTextField(icon: "password", suffixImageName: "eye")
        return textField
    }()
    
    lazy var repeatPasswordLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.label
        label.text = NSLocalizedString("ChangePassword-RepeatPassword", comment: "Құпия сөз") 
        return label
    }()
    
    lazy var repeatPasswordTextField: OZTextField = {
        let textField = OZTextField()
        textField.placeholder = NSLocalizedString("SignIn-YourPassword", comment: "Сіздің құпия сөзіңіз")
        textField.configureTextField(icon: "password", suffixImageName: "eye")
        return textField
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setTabBarHidden(false)
    }
    

}


extension ChangePasswordViewController {
    
    fileprivate func setupUI() {
        view.backgroundColor = Style.Colors.background
        
        navigationItem.title = NSLocalizedString("Profile-ChangePassword", comment: "Құпия сөзді өзгерту")
        
        setupPasswordLabel()
        setupPasswordTextField()
        
        setupRepeatPasswordLabel()
        setupRepeatPasswordTextField()
    }
    
    fileprivate func setupPasswordLabel() {
        view.addSubview(passwordLabel)
        
        passwordLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.left.equalToSuperview().inset(24)
        }
    }
    
    fileprivate func setupPasswordTextField() {
        view.addSubview(passwordTextField)
        
        passwordTextField.snp.makeConstraints { make in
            make.top.equalTo(passwordLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    
    fileprivate func setupRepeatPasswordLabel() {
        view.addSubview(repeatPasswordLabel)
        
        repeatPasswordLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).inset(-24)
            make.left.equalToSuperview().inset(24)
        }
    }
    
    fileprivate func setupRepeatPasswordTextField() {
        view.addSubview(repeatPasswordTextField)
        
        repeatPasswordTextField.snp.makeConstraints { make in
            make.top.equalTo(repeatPasswordLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    
    
}
