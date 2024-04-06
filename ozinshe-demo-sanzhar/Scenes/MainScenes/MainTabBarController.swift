//
//  MainTabBarController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 11.03.2024.
//

import UIKit

class MainTabBarController: UITabBarController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewControllers()
        
        tabBar.backgroundColor = Style.Colors.gray800
        tabBar.barTintColor = Style.Colors.gray800
    }
    
    func setupViewControllers() {
        let homeViewController = HomeNavigationViewController()
        homeViewController.tabBarItem.image = UIImage(named: "Home", in: Bundle(for: MovieInfoViewController.self), compatibleWith: nil)
        homeViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0);
        
        let searchViewController = SearchNavigationViewController()
        searchViewController.tabBarItem.image = UIImage(named: "Search", in: Bundle(for: MainTabBarController.self), compatibleWith: nil)
        searchViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0);
        
        let favoritesViewController = FavoritesNavigationViewController()
        favoritesViewController.tabBarItem.image = UIImage(named: "Favorites", in: Bundle(for: MainTabBarController.self), compatibleWith: nil)
        favoritesViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0);
        
        let profileViewController = ProfileNavigationViewController()
        profileViewController.tabBarItem.image = UIImage(named: "Profile", in: Bundle(for: MainTabBarController.self), compatibleWith: nil)
        profileViewController.tabBarItem.imageInsets = UIEdgeInsets(top: 8, left: 0, bottom: -8, right: 0);
        
        viewControllers = [
            homeViewController,
            searchViewController,
            favoritesViewController,
            profileViewController
        ]
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        Logger.log(.warning, "theme changed to \(traitCollection.userInterfaceStyle.rawValue)")
    }
    
    
}
