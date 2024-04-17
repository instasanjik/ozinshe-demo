//
//  OZLocalizedButton.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 15.04.2024.
//

import UIKit

class OZLocalizedButton: UIButton {
    
    var localizedKey: String = ""
    
    func localize() {
        self.setTitle(self.localizedKey.localized(), for: .normal) 
    }
    
    
}
