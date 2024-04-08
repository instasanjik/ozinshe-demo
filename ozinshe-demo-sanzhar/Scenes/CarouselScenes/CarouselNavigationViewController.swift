//
//  CarouselNavigationViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 29.03.2024.
//

import UIKit

class CarouselNavigationViewController: UINavigationController {

    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupController()
    }
    

}


// MARK: - UI Setups

private extension CarouselNavigationViewController {
    
    func setupController() {
        self.viewControllers = [CarouselViewController()]
        self.topViewController?.extendedLayoutIncludesOpaqueBars = false
    }
    
    
}
