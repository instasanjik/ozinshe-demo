//
//  SceneDelegate.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 26.02.2024.
//

import UIKit
import SkeletonView
import SVProgressHUD

var DEFAULT_ANIMATION = SkeletonAnimationBuilder().makeSlidingAnimation(withDirection: .topLeftBottomRight)

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    static var keyWindow: UIWindow? {
        let scenes = UIApplication.shared.connectedScenes
        let windowScene = scenes.first as? UIWindowScene
        let keyWindow = windowScene?.windows.first
        return keyWindow
    }

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(frame: windowScene.coordinateSpace.bounds)
        window?.windowScene = windowScene
        
        
        SVProgressHUD.setMinimumDismissTimeInterval(1)
        
        if let accessToken = UserDefaults.standard.string(forKey: "accessToken") {
            Storage.sharedInstance.accessToken = accessToken
            window?.rootViewController = MainTabBarController()
        } else {
            let firstTime = !UserDefaults.standard.bool(forKey: "carouselViewed")
            if firstTime {
                LanguageManager.changeLanguage(to: LanguageManager.languages.first!)
                window?.rootViewController = CarouselViewController()
            } else {
                window?.rootViewController = SignInNavigationViewController()
            }
        }
        
        window?.tintColor = Style.Colors.purple500
        window?.makeKeyAndVisible()
        
        SkeletonAppearance.default.gradient = SkeletonGradient(colors: [Style.Colors.gray800, Style.Colors.background, Style.Colors.gray800])
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    func sceneDidEnterBackground(_ scene: UIScene) {
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.
    }

    static func restartApp(){
        AppDelegate.setupNavigationBarsColors()
        SceneDelegate.keyWindow?.rootViewController = MainTabBarController()
        if let tabBarController = SceneDelegate.keyWindow?.rootViewController as? MainTabBarController {
            tabBarController.selectedIndex = 3
        }
        
        SkeletonAppearance.default.gradient = SkeletonGradient(colors: [Style.Colors.gray800, Style.Colors.background, Style.Colors.gray800])
    }
    
    
}

