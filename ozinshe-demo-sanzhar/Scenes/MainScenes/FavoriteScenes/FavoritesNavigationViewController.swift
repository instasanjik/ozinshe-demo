//
//  FavoritesNavigationViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 29.03.2024.
//

import UIKit

class FavoritesNavigationViewController: UINavigationController {
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    

}


// MARK: - UI Setups

private extension FavoritesNavigationViewController {
    
    func setupController() {
        self.viewControllers = [FavoritesViewController()]
        self.topViewController?.extendedLayoutIncludesOpaqueBars = false
        self.navigationBar.barTintColor = .clear
        self.navigationBar.backgroundColor = .clear
        self.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
    
}
