//
//  RecomendationCollectionViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

class RecomendationCollectionViewCell: UICollectionViewCell {
    
    static let ID: String = "RecomendationCollectionViewCell"
    
    lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "previewImageView")
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.isSkeletonable = true
        return imageView
    }()
    
    lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Қызғалдақтар мекені" // TODO: Link with backend data
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.label
        label.isSkeletonable = true
        label.linesCornerRadius = 4
        return label
    }()
    
    lazy var typeBaseView: UIView = {
        let view = UIView()
        view.backgroundColor = Style.StaticColors.purple500
        view.layer.cornerRadius = 8
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var typeNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Телехикая" // TODO: Link with backend data
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = Style.StaticColors.label
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.text = "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum."  // TODO: Link with backend data
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
        
        setupPreviewImageView()
        setupNameLabel()
        setupDescriptionLabel()
        setupTypeName()
        
        self.isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension RecomendationCollectionViewCell {
    
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
            make.top.equalTo(previewImageView.snp.bottom).inset(-16)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setupDescriptionLabel() {
        self.contentView.addSubview(descriptionLabel)
        
        descriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview()
        }
    }
    
    private func setupTypeName() {
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
