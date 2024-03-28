//
//  ProfileViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 11.03.2024.
//

import UIKit

class ProfileViewController: UITableViewController {
    
    lazy var headerView = ProfileHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.Colors.background
        
        
        tableView.register(ProfileSectionTableViewCell.self, forCellReuseIdentifier: ProfileSectionTableViewCell.ID)
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
}
