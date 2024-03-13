//
//  ConstantData.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import Foundation
import UIKit

struct CardContent {
    let name: String
    let image: UIImage
    
    init(name: String, imageName: String) {
        self.name = name
        self.image = UIImage(named: imageName) ?? UIImage()
    }
}

struct StaticData {
    static let genres: [CardContent] = [
        CardContent(name: NSLocalizedString("Genres-Comedy", comment: ""), imageName: "comedia"),
        CardContent(name: NSLocalizedString("Genres-Family", comment: ""), imageName: "family"),
        CardContent(name: NSLocalizedString("Genres-Science", comment: ""), imageName: "science"),
        CardContent(name: NSLocalizedString("Genres-Entertainment", comment: ""), imageName: "entertainment"),
        CardContent(name: NSLocalizedString("Genres-Fantasy", comment: ""), imageName: "fantasy"),
        CardContent(name: NSLocalizedString("Genres-Adventure", comment: ""), imageName: "adventure"),
        CardContent(name: NSLocalizedString("Genres-Short", comment: ""), imageName: "short"),
        CardContent(name: NSLocalizedString("Genres-Musically", comment: ""), imageName: "musically"),
        CardContent(name: NSLocalizedString("Genres-Sport", comment: ""), imageName: "sport")
    ]
    
    static let ageCategories: [CardContent] = [
        CardContent(name: "8-10 \(NSLocalizedString("Age-yo", comment: "жас"))", imageName: "8-10"),
        CardContent(name: "10-12 \(NSLocalizedString("Age-yo", comment: "жас"))", imageName: "10-12"),
        CardContent(name: "12-14 \(NSLocalizedString("Age-yo", comment: "жас"))", imageName: "12-14"),
        CardContent(name: "14-16 \(NSLocalizedString("Age-yo", comment: "жас"))", imageName: "14-16"),
        CardContent(name: "16-18 \(NSLocalizedString("Age-yo", comment: "жас"))", imageName: "16-18")
    ]
}
