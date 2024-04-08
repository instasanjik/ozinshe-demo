//
//  HomeNavigationViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 29.03.2024.
//

import UIKit

class HomeNavigationViewController: UINavigationController {
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    

}

private extension HomeNavigationViewController {
    
    func setupController() {
        self.viewControllers = [HomeViewController()]
        self.topViewController?.extendedLayoutIncludesOpaqueBars = false
    }
    
    
}
