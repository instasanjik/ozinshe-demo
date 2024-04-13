//
//  PersonalDataViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 28.03.2024.
//

import UIKit
import SVProgressHUD
import SkeletonView
import SnapKit
import Kingfisher


protocol PersonalDataViewControllerDelegate {
    func personnalData(profileWasUpdate userProfile: UserProfile)
}

class PersonalDataViewController: UIViewController {
    
    // MARK: - Internal variables
    
    private var isDataEditing: Bool = false
    private var userProfile: UserProfile = UserProfile() {
        didSet {
            updateUserProfileData()
        }
    }
    
    // MARK: - External variables
    
    var delegate: PersonalDataViewControllerDelegate?
    
    
    // MARK: - UI Elements
    
    // MARK: Name elements
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.gray400
        label.text = NSLocalizedString("PersonalData-name", comment: "")
        return label
    }()
    
    private lazy var nameValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = Style.Colors.label
        label.text = getDisplayValue(for: userProfile.name)
        return label
    }()
    
    private lazy var nameTextField: OZTextField = {
        let textField = OZTextField()
        textField.placeholder = nameLabel.text
        textField.padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return textField
    }()
    
    
    // MARK: Phone number elements
    private lazy var phoneNumberLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.gray400
        label.text = NSLocalizedString("PersonalData-phoneNumber", comment: "")
        return label
    }()
    
    private lazy var phoneNumberValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = Style.Colors.label
        label.text = getDisplayValue(for: userProfile.phoneNumber)
        return label
    }()
    
    private lazy var phoneNumberTextField: OZPhoneNumberTextField = {
        let textField = OZPhoneNumberTextField()
        textField.placeholder = phoneNumberLabel.text
        textField.padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return textField
    }()
    
    
    // MARK: Birthday date elements
    private lazy var birthdayDateLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.gray400
        label.text = NSLocalizedString("PersonalData-birhdayDate", comment: "")
        return label
    }()
    
    private lazy var birthdayDateValueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = Style.Colors.label
        if userProfile.birthDate.isEmpty {
            label.text = NSLocalizedString("PersonalData-NoData", comment: "")
        } else {
            label.text = userProfile.birthDate.beautifulDateDisplay()
        }
        return label
    }()
    
    private lazy var birthdayDateDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.contentHorizontalAlignment = .left
        datePicker.setValue(UIColor.white, forKeyPath: "textColor")
        if #available(iOS 13.4, *) {
            datePicker.preferredDatePickerStyle = .compact
        }
        if #available(iOS 15, *) {
            datePicker.maximumDate = .now
        } else {
            datePicker.maximumDate = Calendar.current.date(byAdding: .year, value: 0, to: Date())
        }
        return datePicker
    }()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setTabBarHidden(false)
    }
    
}


// MARK: - UI Setups

private extension PersonalDataViewController {
    
    func setupUI() {
        view.backgroundColor = Style.Colors.background
        setupNavigationBar()
        
        setupNameViews()
        setupPhoneNumberViews()
        setupBirthdayDateViews()
    }
    
    func setupNavigationBar() {
        self.title = "Personal data"
        
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItems = [editButton]
    }
    
    
    // MARK: Setup Name Views
    
    func setupNameViews() {
        setupNameLabel()
        setupNameValueLabel()
    }
    
    func setupNameLabel() {
        self.view.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.left.right.equalToSuperview().inset(24)
        }
    }
    
    func setupNameValueLabel() {
        self.view.addSubview(nameValueLabel)
        
        nameValueLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-8)
            make.left.right.equalTo(nameLabel)
        }
    }
    
    func setupNameTextField() {
        self.view.addSubview(nameTextField)
        
        nameTextField.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-8)
            make.left.right.equalTo(nameLabel)
            make.height.equalTo(56)
        }
    }
    
    
    // MARK: Setup Phone Number Views
    
    func setupPhoneNumberViews() {
        setupPhoneNumberLabel()
        setupPhoneNumberValueLabel()
    }
    
    func setupPhoneNumberLabel() {
        phoneNumberLabel.removeFromSuperview()
        self.view.addSubview(phoneNumberLabel)
        
        let topView: UIView
        let topInset: Int
        
        if isDataEditing {
            topView = nameTextField
            topInset = -16
        } else {
            topView = nameValueLabel
            topInset = -36
        }
        
        phoneNumberLabel.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).inset(topInset)
            make.left.right.equalTo(nameLabel)
        }
    }
    
    func setupPhoneNumberValueLabel() {
        self.view.addSubview(phoneNumberValueLabel)
        
        phoneNumberValueLabel.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).inset(-8)
            make.left.right.equalTo(nameLabel)
        }
    }
    
    func setupPhoneNumberTextField() {
        self.view.addSubview(phoneNumberTextField)
        
        phoneNumberTextField.snp.makeConstraints { make in
            make.top.equalTo(phoneNumberLabel.snp.bottom).inset(-8)
            make.left.right.equalTo(nameLabel)
            make.height.equalTo(56)
        }
    }
    
    
    // MARK: Setup Birthday Date Views
    
    func setupBirthdayDateViews() {
        setupBirthdayDateLabel()
        setupBirthdayDateValueLabel()
    }
    
    func setupBirthdayDateLabel() {
        birthdayDateLabel.removeFromSuperview()
        self.view.addSubview(birthdayDateLabel)
        
        let topView: UIView
        let topInset: Int
        
        if isDataEditing {
            topView = phoneNumberTextField
            topInset = -16
        } else {
            topView = phoneNumberValueLabel
            topInset = -36
        }
        
        birthdayDateLabel.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom).inset(topInset)
            make.left.right.equalTo(nameLabel)
        }
    }
    
    func setupBirthdayDateValueLabel() {
        self.view.addSubview(birthdayDateValueLabel)
        
        birthdayDateValueLabel.snp.makeConstraints { make in
            make.top.equalTo(birthdayDateLabel.snp.bottom).inset(-8)
            make.left.right.equalTo(nameLabel)
        }
    }
    
    func setupBirthdayDateDatePicker() {
        self.view.addSubview(birthdayDateDatePicker)
        
        birthdayDateDatePicker.snp.makeConstraints { make in
            make.top.equalTo(birthdayDateLabel.snp.bottom).inset(-8)
            make.left.right.equalTo(nameLabel)
        }
    }
    
}


// MARK: - Internal functions

private extension PersonalDataViewController {
    
    func getDisplayValue(for text: String) -> String {
        if text.isEmpty {
            return NSLocalizedString("PersonalData-NoData", comment: "")
        }
        return text
    }
    
    func updatePageState() {
        isDataEditing.toggle()
        if isDataEditing {
            nameValueLabel.removeFromSuperview()
            setupNameTextField()
            
            phoneNumberValueLabel.removeFromSuperview()
            setupPhoneNumberLabel()
            setupPhoneNumberTextField()
            
            birthdayDateValueLabel.removeFromSuperview()
            setupBirthdayDateLabel()
            setupBirthdayDateDatePicker()
        } else {
            nameTextField.removeFromSuperview()
            setupNameValueLabel()
            
            phoneNumberTextField.removeFromSuperview()
            setupPhoneNumberLabel()
            setupPhoneNumberValueLabel()
            
            birthdayDateDatePicker.removeFromSuperview()
            setupBirthdayDateLabel()
            setupBirthdayDateValueLabel()
        }
        navigationItem.rightBarButtonItems?.first?.title = isDataEditing ? "Save" : "Edit"
    }
    
    func updateUserProfileData() {
        delegate?.personnalData(profileWasUpdate: userProfile)
        nameValueLabel.text = getDisplayValue(for: userProfile.name)
        phoneNumberValueLabel.text = getDisplayValue(for: userProfile.phoneNumber)
        if userProfile.birthDate.isEmpty {
            birthdayDateValueLabel.text = NSLocalizedString("PersonalData-NoData", comment: "")
        } else {
            birthdayDateValueLabel.text = userProfile.birthDate.beautifulDateDisplay()
        }
    }
    
    
    
}


// MARK: - External functions

extension PersonalDataViewController {
    
    func setupController(with userProfile: UserProfile) {
        self.userProfile = userProfile
    }
    
    
}


// MARK: - Targets

private extension PersonalDataViewController {
    
    @objc func editTapped() {
        if isDataEditing {
            let name: String = nameTextField.text ?? ""
            let phoneNumber: String = phoneNumberTextField.text ?? ""
            let birhdayDate: String = birthdayDateDatePicker.date.shortDate
            let updatedProfile = UserProfile(id: userProfile.id,
                                             name: name,
                                             phoneNumber: phoneNumber,
                                             birtdayDate: birhdayDate,
                                             email: userProfile.email
            )
            SVProgressHUD.show(withStatus: "Uploading")
            CoreService.shared.updateProfileData(userProfile: updatedProfile) { success, errorMessage in
                if success {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
                        SVProgressHUD.showSuccess(withStatus: "Success")
                        self.userProfile = updatedProfile
                        self.updatePageState()
                    }
                } else {
                    SVProgressHUD.showError(withStatus: "Something went wrong, please, try again later") // TODO: Localize
                    print(errorMessage ?? "")
                }
            }
        } else {
            updatePageState()
        }
    }
    
    
}

