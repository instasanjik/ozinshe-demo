//
//  ContentCategoryCollectionViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 20.03.2024.
//

import UIKit
import SnapKit

class ContentCategoryCollectionViewCell: UICollectionViewCell {
    
    // MARK: - External variables
    
    static let ID: String = "ContentCategoryCollectionViewCell"
    
    
    // MARK: - Internal variables
    
    override var isSelected: Bool {
        didSet {
            self.backgroundColor = isSelected ? Style.Colors.gray800 : Style.Colors.gray700
        }
    }
    
    
    // MARK: - UI Elements
    
    private lazy var contentCategoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Style.Colors.label
        return label
    }()
    
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: - UI Setups

private extension ContentCategoryCollectionViewCell {
    
    func setupUI() {
        self.backgroundColor = Style.Colors.gray700
        self.layer.cornerRadius = 8
        self.layer.borderWidth = 1
        self.layer.borderColor = Style.Colors.gray700.cgColor
        
        setupContentCategoryLabel()
    }
    
    func setupContentCategoryLabel() {
        self.addSubview(contentCategoryLabel)
        
        contentCategoryLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(16)
            make.top.bottom.equalToSuperview().inset(8)
        }
    }
    
    
}


// MARK: - External functions

extension ContentCategoryCollectionViewCell {
    
    func configureCell(categoryName: String) {
        self.contentCategoryLabel.text = categoryName
    }
    
    
}
