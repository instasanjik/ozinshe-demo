//
//  GalleryListCollectionViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

class GalleryListCollectionViewCell: UICollectionViewCell {
    
    static let ID: String = "GalleryListCollectionViewCell"
    
    lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "previewImageView")
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Қызғалдақтар мекені"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Style.Colors.label
        label.numberOfLines = 1 // TODO: When skeleton is stop - make 2 lines
        label.isSkeletonable = true
        label.linesCornerRadius = 2
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "2-бөлім"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Style.Colors.gray400
        label.isSkeletonable = true
        label.linesCornerRadius = 2
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupPreviewImageView()
        setupNameLabel()
        setupDescriptionLabel()
        
        self.isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension GalleryListCollectionViewCell {
    
    private func setupPreviewImageView() {
        self.contentView.addSubview(previewImageView)
        
        previewImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(164)
        }
    }
    
    private func setupNameLabel() {
        self.contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(previewImageView.snp.bottom).inset(-8)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setupDescriptionLabel() {
        self.contentView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-4)
            make.left.right.equalToSuperview()
        }
    }
    
    
}

