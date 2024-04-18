//
//  HeaderTableViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import UIKit
import SnapKit
import SkeletonView


// MARK: - Protocol: HeaderTableViewCellDelegate
protocol HeaderTableViewCellDelegate: AnyObject {
    func headerCell(didTapMovie movie: MovieWithDetails)
}


class HeaderTableViewCell: UITableViewCell {
    
    // MARK: - Public variables
    
    static let ID: String = "HeaderTableViewCell"
    public var delegate: HeaderTableViewCellDelegate?
    
    
    // MARK: - Internal variables
    
    private var bannerList: [MovieBanner] = [] {
        didSet {
            itemCount = bannerList.count
            movieBannersCollectionView.reloadData()
        }
    }
    private var itemCount = 5 // default value for showing skeleton
    
    
    // MARK: - UI Elements
    
    private lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ozinshe-logo-mainpage")
        return imageView
    }()
    
    private lazy var movieBannersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.itemSize = CGSizeMake(300, 220)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(MovieBannerCollectionViewCell.self,
                                forCellWithReuseIdentifier: MovieBannerCollectionViewCell.ID)
        
        collectionView.isSkeletonable = true
        return collectionView
    }()

    
    // MARK: - View Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}


// MARK: - UI Setups

private extension HeaderTableViewCell {
    
    func setupUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        self.isSkeletonable = true
        self.contentView.isSkeletonable = true
        
        setupLogoImageView()
        setupMovieBannerCollectionView()
        contentView.startSkeletonAnimation()
    }
    
    func setupLogoImageView() {
        self.contentView.addSubview(logoImageView)
        
        logoImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(16)
            make.left.equalToSuperview().inset(24)
            make.width.equalTo(94)
            make.height.equalTo(40)
        }
    }
    
    func setupMovieBannerCollectionView() {
        self.contentView.addSubview(movieBannersCollectionView)
        
        movieBannersCollectionView.snp.makeConstraints { make in
            make.top.equalTo(logoImageView.snp.bottom).inset(-32)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    
}


// MARK: - External functions

extension HeaderTableViewCell {
    
    func configureCell(_ bannersList: [MovieBanner]) {
        self.bannerList = bannersList
    }
    
    public func showSkeletonWithAnimation() {
        movieBannersCollectionView.showAnimatedGradientSkeleton(animation: DEFAULT_ANIMATION)
    }
    
    public func hideSkeletonAnimation() {
        movieBannersCollectionView.hideSkeleton()
    }
    
    
}


// MARK: - CollectionViewDataSource

extension HeaderTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieBannerCollectionViewCell.ID, for: indexPath) as! MovieBannerCollectionViewCell
        if !bannerList.isEmpty {
            cell.configureCell(movieBanner: bannerList[indexPath.row])
        }
        return cell
    }
    
    
}


// MARK: - CollectionViewDelegate

extension HeaderTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.headerCell(didTapMovie: bannerList[indexPath.row].movie)
    }
    
    
}
