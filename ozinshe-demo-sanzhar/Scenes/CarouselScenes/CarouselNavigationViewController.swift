//
//  CarouselNavigationViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 29.03.2024.
//

import UIKit

class CarouselNavigationViewController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.viewControllers = [CarouselViewController()]
        self.topViewController?.extendedLayoutIncludesOpaqueBars = false
    }
    

}
