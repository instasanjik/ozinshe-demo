//
//  SearchNavigationViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 29.03.2024.
//

import UIKit

class SearchNavigationViewController: UINavigationController {
    
    // MARK: View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
        setupController()
    }
    

}


// MARK: - UI Setups

private extension SearchNavigationViewController {
    
    func setupController() {
        self.viewControllers = [SearchViewController()]
        self.topViewController?.extendedLayoutIncludesOpaqueBars = false
    }
    
    
}
