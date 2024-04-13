//
//  OZButton.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.02.2024.
//

import UIKit
import SnapKit

final class OZButton: UIButton {
    
    // MARK: - External variables
    var titleText: String? {
        didSet {
            setTitle(titleText, for: .normal)
            setTitleColor(UIColor.white, for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        }
    }
    
    
    // MARK: - Overriding internal functions
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }
    
    // MARK: - UI Setups
    func setupUI() {
        clipsToBounds = true
        layer.cornerRadius = 12
        backgroundColor = Style.Colors.purple500
        snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(Screen.width - (24 * 2))
        }
    }
    
    
}
