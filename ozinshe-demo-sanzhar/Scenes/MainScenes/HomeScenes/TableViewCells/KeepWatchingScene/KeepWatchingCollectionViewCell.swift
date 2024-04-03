//
//  KeepWatchingCollectionViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

class KeepWatchingCollectionViewCell: UICollectionViewCell {
    
    static let ID: String = "KeepWatchingCollectionViewCell"
    
    lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "previewImageView")
        imageView.layer.cornerRadius = 8
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isSkeletonable = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Қызғалдақтар мекені" // TODO: Link with backend
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Style.Colors.label
        label.isSkeletonable = true
        label.linesCornerRadius = 2
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "2-бөлім" // TODO: Link with backend
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Style.Colors.gray400
        label.numberOfLines = 2
        label.isSkeletonable = true
        label.linesCornerRadius = 2
        label.skeletonTextNumberOfLines = 1
        return label
        
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension KeepWatchingCollectionViewCell {
    
    fileprivate func setupUI() {
        
        setupPreviewImageView()
        setupNameLabel()
        setupDescriptionLabel()
        
        self.isSkeletonable = true
    }
    
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


extension KeepWatchingCollectionViewCell {
    
    public func configureCell(movie: MovieWithDetails) {
        self.previewImageView.kf.setImage(with: URL(string: movie.poster_link))
        self.nameLabel.text = movie.name
        self.descriptionLabel.text = movie.genres.first?.name ?? ""
    }
    
    
}
