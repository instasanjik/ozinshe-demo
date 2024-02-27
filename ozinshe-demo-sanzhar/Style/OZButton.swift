//
//  OZButton.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.02.2024.
//

import UIKit
import SnapKit

class OZButton: UIButton {
    
    var titleText: String? {
        didSet {
            setTitle(titleText, for: .normal)
            setTitleColor(UIColor.white, for: .normal)
            titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .semibold)
        }
    }
    

    override init(frame: CGRect){
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupUI()
    }

    func setupUI() {
        clipsToBounds = true
        layer.cornerRadius = 12
        backgroundColor = Style.Colors.purple
        snp.makeConstraints { make in
            make.height.equalTo(56)
            make.width.equalTo(Screen.width - (24 * 2))
        }
    }
}
