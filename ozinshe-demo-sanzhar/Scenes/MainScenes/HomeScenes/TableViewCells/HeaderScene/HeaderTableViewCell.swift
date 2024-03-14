//
//  HeaderTableViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

class HeaderTableViewCell: UITableViewCell {
    
    static let ID: String = "HeaderTableViewCell"
    
    lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ozinshe-logo-mainpage")
        return imageView
    }()
    
    lazy var recomentationsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.itemSize = CGSizeMake(300, 240)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(RecomendationCollectionViewCell.self,
                                forCellWithReuseIdentifier: RecomendationCollectionViewCell.ID)
        
        collectionView.isSkeletonable = true
        return collectionView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        backgroundColor = .clear
        
        self.isSkeletonable = true
        
        setupLogoImageView()
        setupRecomendationsCollectionView()
        
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}


// MARK: UI Setups
extension HeaderTableViewCell {
    
    private func setupLogoImageView() {
        self.contentView.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(24)
            make.width.equalTo(94)
            make.height.equalTo(40)
        }
    }
    
    private func setupRecomendationsCollectionView() {
        self.contentView.addSubview(recomentationsCollectionView)
        
        recomentationsCollectionView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).inset(-32)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    
}


extension HeaderTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: RecomendationCollectionViewCell.ID, for: indexPath)
        return cell
    }
    
    
}

extension HeaderTableViewCell {
    
    public func showSkeletonWithAnimation() {
        recomentationsCollectionView.showAnimatedGradientSkeleton(animation: DEFAULT_ANIMATION)
    }
    
    public func hideSkeletonAnimation() {
        recomentationsCollectionView.hideSkeleton()
    }
    
    
}
