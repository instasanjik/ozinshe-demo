//
//  OZLocalizedLabel.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 15.04.2024.
//

import UIKit

class OZLocalizedLabel: UILabel {
    
    var localizedKey: String = ""
    
    func localize() {
        self.text = self.localizedKey.localized()
    }
    
    
}
