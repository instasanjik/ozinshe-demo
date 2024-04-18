//
//  ProfileViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 11.03.2024.
//

import UIKit
import SnapKit
import SVProgressHUD

// MARK: - CellType
enum CellType {
    case labelAndChevron
    case chevronOnly
    case switchOnly
}


class ProfileViewController: UITableViewController {
    
    // MARK: - External variables
    
    var userProfile: UserProfile? {
        didSet {
            headerView.updateData(name: userProfile?.name, email: userProfile?.email)
        }
    }
    
    
    // MARK: - Internal variables
    
    var switchControlIsON = true
    var profileSettings: [(String, CellType)] {
        get {
            return [
                ("Profile-PersonalData".localized(), .labelAndChevron),
                ("Profile-ChangePassword".localized(), .chevronOnly),
                ("Profile-Language".localized(), .labelAndChevron),
                ("Profile-TermsOfUse".localized(), .chevronOnly),
                ("Profile-DarkMode".localized(), .switchOnly)
            ]
        }
    }
    
    
    // MARK: - UI Elements
    
    private lazy var headerView = ProfileHeaderView()
    
    private lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadData()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        if userProfile == nil {
            downloadData()
        }
    }
    
}


// MARK: - UI Setups

private extension ProfileViewController {
    
    func setupUI() {
        self.view.backgroundColor = Style.Colors.background
        settingNavigationBar()
        addObservers()
        
        tableView.register(ProfileSectionTableViewCell.self,
                           forCellReuseIdentifier: ProfileSectionTableViewCell.ID)
    }
    
    func addObservers() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.localizePage), name: Notification.Name("OZLanguageChanged"), object: nil)
    }
    
    func settingNavigationBar() {
        navigationItem.title = "Profile-Profile".localized()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(leaveTapped))
        navigationItem.rightBarButtonItem?.tintColor = Style.Colors.error
    }
    
    func setupBlurEffectView() {
        blurEffectView.alpha = 0
        
        navigationController?.view.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(view)
        }
        
        UIView.animate(withDuration: 0.3) { [self] in
            blurEffectView.alpha = 1
        }
    }
    
    func showSelectionLanguageView() {
        setupBlurEffectView()
        setTabBarHidden(true)
        let vc = SelectionLanguageViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    func showPersonalDataViewController() {
        if let userProfile = userProfile {
            setTabBarHidden(true)
            let vc = PersonalDataViewController()
            vc.setupController(with: userProfile)
            vc.delegate = self
            navigationController?.pushViewController(vc, animated: true)
        } else {
            SVProgressHUD.showError(withStatus: "General-UnknownError".localized())
        }
    }
    
    func showLeaveConfirmationViewController() {
        if let userProfile = userProfile {
            setupBlurEffectView()
            setTabBarHidden(true)
            let vc = LeaveConfirmationViewController()
            vc.modalPresentationStyle = .overCurrentContext
            vc.delegate = self
            self.present(vc, animated: true, completion: nil)
        } else {
            SVProgressHUD.showError(withStatus: "General-UnknownError".localized())
        }
    }
    
    func showChangePasswordViewController() {
        setTabBarHidden(true)
        let vc = ChangePasswordViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showTermsOfUseViewController() {
        setTabBarHidden(true)
        let vc = TermsOfUseViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


// MARK: - Targets

private extension ProfileViewController {
    
    @objc func leaveTapped() {
        showLeaveConfirmationViewController()
    }
    
    func changeThemeTapped() {
        let preference = UserDefaults.standard.bool(forKey: "isOSThemeLight")
        SceneDelegate.keyWindow?.overrideUserInterfaceStyle = preference ? .dark : .light
        UserDefaults.standard.setValue(!switchControlIsON, forKey: "isOSThemeLight")
        SceneDelegate.restartApp()
    }
    
    @objc func localizePage() {
        self.navigationItem.title = "Profile-Profile".localized()
        if let header = tableView.headerView(forSection: 0) as? ProfileHeaderView {
            header.localizeData()
        }
        for index in tableView.visibleCells.indices {
            if let cell = tableView.visibleCells[index] as? ProfileSectionTableViewCell {
                cell.setupCellData(cellData: profileSettings[index])
                if index == 2 {
                    cell.setupCellOptionText()
                }
            }
        }
    }
    
    
}


// MARK: - Internal functions

private extension ProfileViewController {
    
    func downloadData() {
        CoreService.shared.getProfileData { success, errorMessage, profile in
            self.userProfile = profile
        }
    }
    
    
}


// MARK: - Delegates

// MARK: SelectionLanguageViewControllerDelegate
extension ProfileViewController: SelectionLanguageViewControllerDelegate {
    
    func selectionLanguageViewWillDisappear() {
        setTabBarHidden(false)
        UIView.animate(withDuration: 0.3) { [self] in
            blurEffectView.alpha = 0
        } completion: { complete in
            self.blurEffectView.removeFromSuperview()
        }
    }
    
    
}


// MARK: LeaveConfirmationViewControllerDelegate
extension ProfileViewController: LeaveConfirmationViewControllerDelegate {
    
    func leaveConfirmationViewWillDisappear() {
        setTabBarHidden(false)
        UIView.animate(withDuration: 0.3) { [self] in
            blurEffectView.alpha = 0
        } completion: { complete in
            self.blurEffectView.removeFromSuperview()
        }
    }
    
    
}

// MARK: PersonalDataViewControllerDelegate
extension ProfileViewController: PersonalDataViewControllerDelegate {
    
    func personnalData(profileWasUpdate userProfile: UserProfile) {
        self.userProfile = userProfile
    }
    
    
}


// MARK: TableViewDataSource
extension ProfileViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSectionTableViewCell.ID, for: indexPath) as! ProfileSectionTableViewCell
        cell.setupCellData(cellData: profileSettings[indexPath.row])
        if indexPath.row == 2 {
            cell.setupCellOptionText()
        }
        cell.delegate = self
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return profileSettings.count
    }
    
    
}


// MARK: TableViewDelegate
extension ProfileViewController {
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 251
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: showPersonalDataViewController()
        case 1: showChangePasswordViewController()
        case 2: showSelectionLanguageView()
        case 3: showTermsOfUseViewController()
        default: return
        }
    }
    
    
}


// MARK: ProfileSectionTableViewCellDelegate
extension ProfileViewController: ProfileSectionTableViewCellDelegate {
    
    func presentThemeChangingWarning(switchControlIsON: Bool) {
        self.switchControlIsON = switchControlIsON
        self.changeThemeTapped()
    }
    
    
}
