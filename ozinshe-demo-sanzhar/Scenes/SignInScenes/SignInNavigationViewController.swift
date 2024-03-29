//
//  SignInNavigationViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 29.03.2024.
//

import UIKit

class SignInNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [SignInViewController()]
        self.topViewController?.extendedLayoutIncludesOpaqueBars = false
    }
    

}
