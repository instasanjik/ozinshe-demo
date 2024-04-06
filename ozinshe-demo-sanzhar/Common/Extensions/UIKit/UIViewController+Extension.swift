//
//  UIViewController+Extension.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 28.03.2024.
//

import UIKit

var originalTabBarFrame: CGRect?

extension UIViewController {
    
    func setTabBarHidden(_ hidden: Bool) {
        self.tabBarController?.tabBar.isHidden = hidden
        self.tabBarController?.tabBar.isTranslucent = hidden
    }
    
    func setNavigationBarHidden() {
        if #available(iOS 15.0, *) {
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithTransparentBackground()
            navigationController?.navigationBar.standardAppearance = navigationBarAppearance
            navigationController?.navigationBar.compactAppearance = navigationBarAppearance
            navigationController?.navigationBar.scrollEdgeAppearance = navigationBarAppearance
            let backButton = UIBarButtonItem()
            backButton.title = ""
            self.navigationController?.navigationBar.topItem?.backBarButtonItem = backButton
        }
    }

    
}
