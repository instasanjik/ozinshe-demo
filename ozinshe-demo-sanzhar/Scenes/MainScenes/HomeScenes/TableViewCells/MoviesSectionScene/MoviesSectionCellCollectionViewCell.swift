//
//  MoviesSectionCellCollectionViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import UIKit
import SnapKit
import SkeletonView
import Kingfisher

class MoviesSectionCellCollectionViewCell: UICollectionViewCell {
    
    // MARK: - External variables
    
    static let ID: String = "GalleryListCollectionViewCell"
    
    
    // MARK: - UI Elements
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "previewImageView")
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "SPLASH_TEXT SPLASH_TEXT"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Style.Colors.label
        label.numberOfLines = 2 
        label.skeletonTextNumberOfLines = 1
        label.isSkeletonable = true
        label.linesCornerRadius = 2
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "SPLASH_TEXT" 
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Style.Colors.gray400
        label.numberOfLines = 2
        label.isSkeletonable = true
        label.linesCornerRadius = 2
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

private extension MoviesSectionCellCollectionViewCell {
    
    func setupUI() {
        self.isSkeletonable = true
        
        setupPreviewImageView()
        setupNameLabel()
        setupDescriptionLabel()
    }
    
    func setupPreviewImageView() {
        self.contentView.addSubview(previewImageView)
        
        previewImageView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.height.equalTo(164)
        }
    }
    
    func setupNameLabel() {
        self.contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(previewImageView.snp.bottom).inset(-8)
            make.left.right.equalToSuperview()
        }
    }
    
    func setupDescriptionLabel() {
        self.contentView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-4)
            make.left.right.equalToSuperview()
        }
    }
    
    
}


// MARK: - External functions

extension MoviesSectionCellCollectionViewCell {
    
    func configureCell(movie: MovieWithDetails) {
        self.previewImageView.kf.setImage(with: URL(string: movie.poster_link))
        self.nameLabel.text = movie.name
        self.descriptionLabel.text = movie.description
    }
    
    
}
