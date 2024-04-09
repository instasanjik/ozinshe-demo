//
//  PersonalDataViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 28.03.2024.
//

import UIKit
import SVProgressHUD
import SkeletonView

class PersonalDataViewController: UITableViewController {
    
    // MARK: - Internal variables
    
    private let DEFAULT_HEIGHT_CELL: CGFloat = 88
    private let EDITING_CELL_HEIGHT: CGFloat = 133
    
    private var isDataEditing: Bool = true
    
    
    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Personal data"
        
        let editButton = UIBarButtonItem(title: "Edit", style: .plain, target: self, action: #selector(editTapped))
        navigationItem.rightBarButtonItems = [editButton]
        
        view.backgroundColor = Style.Colors.background
        tableView.register(PersonalDataTableViewCell.self, forCellReuseIdentifier: PersonalDataTableViewCell.ID)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setTabBarHidden(false)
    }

}

private extension PersonalDataViewController {
    
    @objc func editTapped() {
        if isDataEditing {
            // send data to the server
//            CoreService.shared.updateProfileData(userProfile: UserProfile, completionHandler: <#T##(Bool, String?) -> Void##(Bool, String?) -> Void##(_ success: Bool, _ errorMessage: String?) -> Void#>)
            updatePageState()
        } else {
            updatePageState()
        }
    }
    
    func updatePageState() {
        isDataEditing.toggle()
        tableView.reloadData()
        navigationItem.rightBarButtonItems?.first?.title = isDataEditing ? "Save" : "Edit"
    }
    
    
}

extension PersonalDataViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonalDataTableViewCell.ID, for: indexPath) as! PersonalDataTableViewCell
        cell.setupCell(sectionName: NSLocalizedString(StaticData.personalDataCell[indexPath.row], 
                                                      comment: ""),
                       isDataEditing: isDataEditing)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return isDataEditing ? EDITING_CELL_HEIGHT : DEFAULT_HEIGHT_CELL
    }
    
    
}
