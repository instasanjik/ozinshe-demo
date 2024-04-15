//
//  GenresAndAgesCollectionViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import UIKit
import SnapKit
import Kingfisher

class GenresAndAgesCollectionViewCell: UICollectionViewCell {
    
    // MARK: - External variables
    
    static let ID: String = "GenresAndAgesCollectionViewCell"
    
    
    // MARK: - UI Elements
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "previewImageView")
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "SPLASH_TEXT"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = Style.StaticColors.label
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "SPLASH_TEXT" 
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Style.Colors.gray400
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

extension GenresAndAgesCollectionViewCell {
    
    func setupUI() {
        setupPreviewImageView()
        setupNameLabel()
    }
    
    func setupPreviewImageView() {
        self.contentView.addSubview(previewImageView)
        
        previewImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(112)
        }
    }
    
    func setupNameLabel() {
        self.contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(4)
            make.centerY.equalToSuperview()
        }
    }
    
    
}


// MARK: - External functions

extension GenresAndAgesCollectionViewCell{
    
    func configureCell(card: ContentCategory) {
        self.previewImageView.kf.setImage(with: card.previewURL)
        self.nameLabel.text = card.name
    }
    
    
}

