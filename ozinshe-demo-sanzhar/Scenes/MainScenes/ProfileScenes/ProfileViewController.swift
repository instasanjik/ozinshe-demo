//
//  ProfileViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 11.03.2024.
//

import UIKit
import SnapKit

class ProfileViewController: UITableViewController {
    
    lazy var blurEffectView: UIVisualEffectView = {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
//        blurEffectView.alpha = 0.5
        return blurEffectView
    }()
    
    lazy var headerView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "My profile"
        
        view.backgroundColor = Style.Colors.background
        tableView.register(ProfileSectionTableViewCell.self, 
                           forCellReuseIdentifier: ProfileSectionTableViewCell.ID)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupBlurEffectView()
    }
    
}


extension ProfileViewController {
    
    fileprivate func setupBlurEffectView() {
        view.addSubview(blurEffectView)
        
        blurEffectView.snp.makeConstraints { make in
            make.top.bottom.right.left.equalTo(view)
        }
        
        view.bringSubviewToFront(blurEffectView)
    }
    
    fileprivate func showSelectionLanguageView() {
        setupBlurEffectView()
        setTabBarHidden(true)
        let vc: SelectionLanguageViewController = SelectionLanguageViewController()
        vc.modalPresentationStyle = .overCurrentContext
        vc.delegate = self
        self.present(vc, animated: true, completion: nil)
    }
    
    
}

extension ProfileViewController: SelectionLanguageViewControllerDelegate {
    
    func viewWillDisappear() {
        setTabBarHidden(false)
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
        case 2: showSelectionLanguageView()
        default: print(0)
        }
        print(indexPath)
    }
    
    
}
