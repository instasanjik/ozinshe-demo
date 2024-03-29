//
//  PersonalDataViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 28.03.2024.
//

import UIKit

class PersonalDataViewController: UITableViewController {
    
    var isDataEditing: Bool = true {
        didSet {
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.Colors.background
         
        tableView.register(PersonalDataTableViewCell.self, forCellReuseIdentifier: PersonalDataTableViewCell.ID)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setTabBarHidden(false)
    }

}

extension PersonalDataViewController {
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: PersonalDataTableViewCell.ID, for: indexPath) as! PersonalDataTableViewCell
        cell.selectionStyle = .none
        cell.setupUI(isDataEditing: isDataEditing)
        return cell
    }
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return isDataEditing ? 21+8+24+24+56 : 88
    }
    
    
}
