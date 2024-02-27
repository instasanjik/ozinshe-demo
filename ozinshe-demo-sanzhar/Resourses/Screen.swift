//
//  Screen.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.02.2024.
//

import UIKit



public enum ScreenSize {

    public static let width: CGFloat = {
        return UIScreen.main.bounds.width
    }()
    
    public static let height: CGFloat = {
        return UIScreen.main.bounds.height
    }()
    
    
    public static let statusBarHeight: CGFloat = {
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
            let statusBarManager = windowScene.statusBarManager
        else {
            return 0
        }

        let statusBarHeight = statusBarManager.statusBarFrame.height
        return statusBarHeight
    }()
    
    
}

public let Screen = ScreenSize.self

