//
//  ProfileViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 11.03.2024.
//

import UIKit
import SnapKit

class ProfileViewController: UITableViewController {
    
    var userProfile: UserProfile? {
        didSet {
            headerView.emailLabel.text = userProfile?.email ?? ""
        }
    }
    
    lazy var headerView = ProfileHeaderView()
    
    lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        downloadData()
        setupUI()
    }
    
}

// MARK: - UI Setups

private extension ProfileViewController {
    
    func setupUI() {
        view.backgroundColor = Style.Colors.background
        settingNavigationBar()
        tableView.register(ProfileSectionTableViewCell.self,
                           forCellReuseIdentifier: ProfileSectionTableViewCell.ID)
    }
    
    func settingNavigationBar() {
        navigationItem.title = NSLocalizedString("Profile-Profile", comment: "Профиль")
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
        setTabBarHidden(true)
        let vc = PersonalDataViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func showLeaveConfirmationViewController() {
        setupBlurEffectView()
        setTabBarHidden(true)
        let vc = LeaveConfirmationViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
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


// MARK: - Internal functions

private extension ProfileViewController {
    
    func downloadData() {
        CoreService.Worker.getProfileData { success, errorMessage, profile in
            self.userProfile = profile
        }
    }
    
    
}


// MARK: - Delegates

extension ProfileViewController: SelectionLanguageViewControllerDelegate, LeaveConfirmationViewControllerDelegate {
    
    func selectionLanguageViewWillDisappear() {
        setTabBarHidden(false)
        UIView.animate(withDuration: 0.3) { [self] in
            blurEffectView.alpha = 0
        } completion: { complete in
            self.blurEffectView.removeFromSuperview()
        }
    }
    
    func leaveConfirmationViewWillDisappear() {
        setTabBarHidden(false)
        UIView.animate(withDuration: 0.3) { [self] in
            blurEffectView.alpha = 0
        } completion: { complete in
            self.blurEffectView.removeFromSuperview()
        }
    }
    
    
}


// MARK: - TableViewDelegate, TableiViewDataSource

extension ProfileViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSectionTableViewCell.ID, for: indexPath) as! ProfileSectionTableViewCell
        cell.cellData = StaticData.profileSettings[indexPath.row]
        if indexPath.row == 2 {
            cell.optionNameLabel.text = StaticData.getLanguageName()
        }
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return headerView
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 251
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return StaticData.profileSettings.count
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0: showPersonalDataViewController()
        case 1: showChangePasswordViewController()
        case 2: showSelectionLanguageView()
        case 3: showTermsOfUseViewController()
        default: print(indexPath)
        }
    }
    
    
}


// MARK: - Targets

private extension ProfileViewController {
    
    @objc func leaveTapped() {
        showLeaveConfirmationViewController()
    }
    
    
}
