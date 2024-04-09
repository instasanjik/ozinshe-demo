//
//  ProfileNavigationViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 28.03.2024.
//

import UIKit

class ProfileNavigationViewController: UINavigationController {
    
    // MARK: View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    

}


// MARK: - UI Setups

private extension ProfileNavigationViewController {
    
    func setupController() {
        self.viewControllers = [ProfileViewController()]
        self.topViewController?.extendedLayoutIncludesOpaqueBars = false
        self.navigationBar.barTintColor = .clear
        self.navigationBar.backgroundColor = .clear
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    
}
