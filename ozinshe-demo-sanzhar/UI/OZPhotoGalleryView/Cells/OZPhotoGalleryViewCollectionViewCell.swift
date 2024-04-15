//
//  OZPhotoGalleryViewCollectionViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 14.04.2024.
// TODO: Add marks

import UIKit
import Kingfisher

final class OZPhotoGalleryViewCollectionViewCell: UICollectionViewCell {
    
    static let ID: String = "OZPhotoGalleryViewCollectionViewCell"
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(imageView)
        
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}


extension OZPhotoGalleryViewCollectionViewCell {
    
    func configureCell(imageLink: URL) {
        imageView.kf.setImage(with: imageLink)
    }
    
    
}
