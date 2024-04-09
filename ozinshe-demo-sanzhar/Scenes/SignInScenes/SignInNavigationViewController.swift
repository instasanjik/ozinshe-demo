//
//  SignInNavigationViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 29.03.2024.
//

import UIKit

class SignInNavigationViewController: UINavigationController {

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    
    
}


// MARK: - UI Setups

extension SignInNavigationViewController {
    
    func setupController() {
        self.viewControllers = [SignInViewController()]
        self.topViewController?.extendedLayoutIncludesOpaqueBars = false
    }
    
    
}
