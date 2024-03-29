//
//  HomeNavigationViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 29.03.2024.
//

import UIKit

class HomeNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [HomeViewController()]
        self.topViewController?.extendedLayoutIncludesOpaqueBars = false
    }
    

}
