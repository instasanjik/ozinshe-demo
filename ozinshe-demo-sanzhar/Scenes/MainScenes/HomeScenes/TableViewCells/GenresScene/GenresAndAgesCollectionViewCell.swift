//
//  GenresAndAgesCollectionViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import UIKit
import SnapKit

class GenresAndAgesCollectionViewCell: UICollectionViewCell {
    
    static let ID: String = "GenresAndAgesCollectionViewCell"
    
    lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "previewImageView")
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "SPLASH_TEXT"
        label.font = .systemFont(ofSize: 14, weight: .semibold)
        label.textColor = Style.Colors.label
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "SPLASH_TEXT" 
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Style.Colors.gray400
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPreviewImageView()
        setupNameLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension GenresAndAgesCollectionViewCell {
    
    private func setupPreviewImageView() {
        self.contentView.addSubview(previewImageView)
        
        previewImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(112)
        }
    }
    
    private func setupNameLabel() {
        self.contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(4)
            make.centerY.equalToSuperview()
        }
    }
    
    
}



extension GenresAndAgesCollectionViewCell{
    
    public func configureCell(card: ContentCategory) {
        self.previewImageView.kf.setImage(with: card.previewURL)
        self.nameLabel.text = card.name
    }
    
    
}

