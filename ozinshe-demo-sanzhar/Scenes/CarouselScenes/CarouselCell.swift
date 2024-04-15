//
//  CarouselCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.02.2024.
//

import UIKit
import SnapKit

class CarouselCell: UICollectionViewCell {
    
    // MARK: - Public variables
    
    static let cellId = "CarouselCell"
    
    
    // MARK: - UI Elements
    
    private lazy var imageView = UIImageView()
    
    private lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.label
        label.text = "carouselWelcomeText".localized()
        label.isUserInteractionEnabled = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = Style.Colors.gray400
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var gradientView = GradientView()
    
    
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

private extension CarouselCell {
    
    func setupUI() {
        backgroundColor = .clear
        setupImageView()
        setupDescriptionLabel()
        setupGradientView()
        setupWelcomeLabel()
    }
    
    func setupImageView() {
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(self.snp.width).multipliedBy(1.3)
        }
    }
    
    func setupDescriptionLabel() {
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().inset(220)
        }
    }
    
    func setupGradientView() {
        addSubview(gradientView)
        gradientView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.centerY)
            make.bottom.equalTo(imageView.snp.bottom)
        }
    }
    
    func setupWelcomeLabel() {
        addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(310)
        }
    }
    
    
}


// MARK: - Public functions

extension CarouselCell {
    
    public func configureCell(with itemName: String) {
        imageView.image = UIImage(named: itemName)
        descriptionLabel.text = itemName.localized()
    }
    
    
}
