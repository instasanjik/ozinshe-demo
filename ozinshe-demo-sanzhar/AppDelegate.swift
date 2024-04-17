//
//  AppDelegate.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 26.02.2024.
//

import UIKit

var SHOULD_PRINT: Bool = false

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        window = UIWindow(frame: UIScreen.main.bounds)

        AppDelegate.setupNavigationBarsColors()
        
        if #available(iOS 15.0, *) {
            UITableView.appearance().sectionHeaderTopPadding = 8
        }
        
        print(LanguageManager.LocalizedFile["strings"]["SignIn-Description"]["localizations"]["kk-KZ"]["stringUnit"]["value"])
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    static func setupNavigationBarsColors() {
        if #available(iOS 15, *) {
            // MARK: Navigation bar appearance
            let navigationBarAppearance = UINavigationBarAppearance()
            navigationBarAppearance.configureWithOpaqueBackground()
            navigationBarAppearance.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : Style.Colors.label
            ]
            navigationBarAppearance.backButtonAppearance.normal.titleTextAttributes = [
                NSAttributedString.Key.foregroundColor: UIColor.clear
            ]
            navigationBarAppearance.backgroundColor = Style.Colors.background
            UINavigationBar.appearance().standardAppearance = navigationBarAppearance
            UINavigationBar.appearance().compactAppearance = navigationBarAppearance
            UINavigationBar.appearance().scrollEdgeAppearance = navigationBarAppearance
            UINavigationBar.appearance().tintColor = Style.Colors.white
            
            // MARK: Tab bar appearance
            let tabBarAppearance = UITabBarAppearance()
            tabBarAppearance.configureWithOpaqueBackground()
            tabBarAppearance.backgroundColor = Style.Colors.gray800
            UITabBar.appearance().scrollEdgeAppearance = tabBarAppearance
            UITabBar.appearance().standardAppearance = tabBarAppearance
        } else {
            // Fallback for earlier versions
            UINavigationBar.appearance().barTintColor = Style.Colors.background
            UINavigationBar.appearance().titleTextAttributes = [
                NSAttributedString.Key.foregroundColor : Style.Colors.label
            ]
            UIBarButtonItem.appearance().setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.clear], for: .normal)
            UITabBar.appearance().barTintColor = Style.Colors.gray800
        }
    }


}

