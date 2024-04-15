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
    
    // MARK: - External variables
    
    static let ID: String = "SeasonCollectionViewCell"
    
    
    // MARK: - Overriding internal variables
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? Style.Colors.purple400 : Style.Colors.gray700
        }
    }
    
    
    // MARK: - UI Elements
    
    private lazy var seasonLabel: UILabel = {
        let label = UILabel()
        label.text = "SPLASH_TEXT"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Style.StaticColors.label
        return label
    }()
    
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}


// MARK: - UI Setups

private extension SeasonCollectionViewCell {
    
    func setupUI() {
        self.backgroundColor = Style.Colors.gray700
        self.layer.cornerRadius = 8
        
        setupSeasonLabel()
    }
    
    func setupSeasonLabel() {
        self.addSubview(seasonLabel)
        
        seasonLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
    
    
}


// MARK: - External functions

extension SeasonCollectionViewCell {
    
    func configureCell(seasonNumber: Int) {
        self.seasonLabel.text = "\(seasonNumber) \("Seasons-Seasons".localized())"
    }
    
    
}
