//
//  SeasonCollectionViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 17.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

class SeasonCollectionViewCell: UICollectionViewCell {
    
    static let ID: String = "SeasonCollectionViewCell"
    
    
    lazy var seasonLabel: UILabel = {
        let label = UILabel()
        label.text = "1 сезон"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Style.StaticColors.label
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? Style.Colors.purple400 : Style.Colors.gray700
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Style.Colors.gray700
        self.layer.cornerRadius = 8
        
        setupSeasonLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}


extension SeasonCollectionViewCell {
    
    fileprivate func setupSeasonLabel() {
        self.addSubview(seasonLabel)
        
        seasonLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
    
    
}
