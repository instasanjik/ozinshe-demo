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
}

public let Screen = ScreenSize.self

