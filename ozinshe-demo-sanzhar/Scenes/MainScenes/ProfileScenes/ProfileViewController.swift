//
//  ProfileViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 11.03.2024.
//

import UIKit
import SnapKit

class ProfileViewController: UITableViewController {
    
    lazy var headerView = ProfileHeaderView()
    
    lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: .dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        return blurEffectView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        tableView.register(ProfileSectionTableViewCell.self,
                           forCellReuseIdentifier: ProfileSectionTableViewCell.ID)
    }
    
}


extension ProfileViewController {
    
    fileprivate func setupUI() {
        navigationItem.title = "My profile"
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "rectangle.portrait.and.arrow.right"), style: .plain, target: self, action: #selector(leaveTapped))
        navigationItem.rightBarButtonItem?.tintColor = Style.Colors.error

        view.backgroundColor = Style.Colors.background
    }
    
    fileprivate func setupBlurEffectView() {
        blurEffectView.alpha = 0
        
        navigationController?.view.addSubview(blurEffectView)
        blurEffectView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(view)
        }
        
        UIView.animate(withDuration: 0.3) { [self] in
            blurEffectView.alpha = 1
        }
    }
    
    fileprivate func showSelectionLanguageView() {
        setupBlurEffectView()
        setTabBarHidden(true)
        let vc = SelectionLanguageViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    fileprivate func showPersonalDataViewController() {
        setTabBarHidden(true)
        let vc = PersonalDataViewController()
//        vc.delegate = self
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

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


extension ProfileViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ProfileSectionTableViewCell.ID, for: indexPath) as! ProfileSectionTableViewCell
        cell.cellData = StaticData.profileSettings[indexPath.row]
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
        case 1: print(123)
        case 2: showSelectionLanguageView()
        default: print(indexPath)
        }
    }
    
    
}

extension ProfileViewController {
    
    @objc func leaveTapped() {
        print(123)
    }
    
    
}
