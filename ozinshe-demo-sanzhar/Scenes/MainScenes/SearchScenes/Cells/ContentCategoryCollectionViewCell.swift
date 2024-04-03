//
//  ContentCategoryCollectionViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 20.03.2024.
//

import UIKit
import SnapKit

class ContentCategoryCollectionViewCell: UICollectionViewCell {
    
    static let ID: String = "ContentCategoryCollectionViewCell"
    
    
    lazy var contentCategoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Style.StaticColors.label
        return label
    }()
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? Style.Colors.gray800 : Style.Colors.gray700
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Style.Colors.gray700
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = Style.Colors.gray700.cgColor
        
        setupContentCategoryLabel()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    
}

extension ContentCategoryCollectionViewCell {
    
    fileprivate func setupContentCategoryLabel() {
        self.addSubview(contentCategoryLabel)
        
        contentCategoryLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
    
    
}