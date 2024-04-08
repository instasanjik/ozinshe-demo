//
//  MainTabBarController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 11.03.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        setupTabBarAppearance()
    }
    
    
}

// MARK: - Internal functions

private extension MainTabBarController {
    
    func setupTabBarAppearance() {
        tabBar.backgroundColor = Style.Colors.gray800
        tabBar.barTintColor = Style.Colors.gray800
    }
    
    func setupViewControllers() {
        let homeViewController      = makeViewController(controller: HomeNavigationViewController(),
                                                         image: "Home")
        let searchViewController    = makeViewController(controller: SearchNavigationViewController(),
                                                         image: "Search")
        let favoritesViewController = makeViewController(controller: FavoritesNavigationViewController(),
                                                         image: "Favorites")
        let profileViewController   = makeViewController(controller: ProfileNavigationViewController(),
                                                         image: "Profile")
        
        viewControllers = [
            homeViewController,
            searchViewController,
            favoritesViewController,
            profileViewController
        ]
    }
    
    func makeViewController(controller: UINavigationController, image: String) -> UINavigationController {
        let viewController = controller
        viewController.tabBarItem.image = UIImage(named: image)
        viewController.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0)
        return viewController
    }
    
    
}
