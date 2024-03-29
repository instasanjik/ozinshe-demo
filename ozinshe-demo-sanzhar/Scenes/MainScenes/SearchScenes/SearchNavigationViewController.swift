//
//  SearchNavigationViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 29.03.2024.
//

import UIKit

class SearchNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [SearchViewController()]
        self.topViewController?.extendedLayoutIncludesOpaqueBars = false
    }
    

}
