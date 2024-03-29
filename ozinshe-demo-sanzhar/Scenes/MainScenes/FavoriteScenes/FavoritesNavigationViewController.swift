//
//  FavoritesNavigationViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 29.03.2024.
//

import UIKit

class FavoritesNavigationViewController: UINavigationController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [FavoritesViewController()]
        self.topViewController?.extendedLayoutIncludesOpaqueBars = false
    }
    

}
