//
//  MovieBannerCollectionViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

class MovieBannerCollectionViewCell: UICollectionViewCell {
    
    // MARK: - External variables
    
    static let ID: String = "RecomendationCollectionViewCell"
    
    
    // MARK: - UI Elements
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Қызғалдақтар мекені"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.label
        label.isSkeletonable = true
        label.linesCornerRadius = 4
        return label
    }()
    
    private lazy var typeBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = Style.StaticColors.purple500
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var typeNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Телехикая"
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = Style.StaticColors.label
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Style.Colors.gray400
        label.numberOfLines = 2
        label.isSkeletonable = true
        label.linesCornerRadius = 2
        label.skeletonTextNumberOfLines = 1
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

private extension MovieBannerCollectionViewCell {
    
    func setupUI() {
        setupPreviewImageView()
        setupNameLabel()
        setupDescriptionLabel()
        setupTypeName()
        
        self.isSkeletonable = true
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
            make.top.equalTo(previewImageView.snp.bottom).inset(-16)
            make.left.right.equalToSuperview()
        }
    }
    
    func setupDescriptionLabel() {
        self.contentView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview()
        }
    }
    
    func setupTypeName() {
        self.previewImageView.addSubview(typeBaseView)
        
        typeBaseView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().inset(8)
            make.height.equalTo(24)
        }
        
        self.typeBaseView.addSubview(typeNameLabel)
        
        typeNameLabel.snp.makeConstraints { make in
            make.top.bottom.equalToSuperview().inset(4)
            make.left.right.equalToSuperview().inset(8)
        }
    }
    
    
}


// MARK: - External functions

extension MovieBannerCollectionViewCell {    
    
    func configureCell(movieBanner: MovieBanner) {
        previewImageView.kf.setImage(with: URL(string: movieBanner.link))
        nameLabel.text = movieBanner.movie.name
        descriptionLabel.text = movieBanner.movie.description
        if let type = movieBanner.movie.categories.first?.name {
            self.typeNameLabel.text = type
        } else {
            self.typeBaseView.isHidden = true
        }
    }

    
}
