//
//  OZPhotoGalleryView.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 14.04.2024.
//

import UIKit
import SnapKit

final class OZPhotoGalleryView: UIView {
    
    private var numberOfPages: Int = 0
    private var imageURLList = [URL]()
    
    private lazy var contentCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        collectionView.register(OZPhotoGalleryViewCollectionViewCell.self, forCellWithReuseIdentifier: OZPhotoGalleryViewCollectionViewCell.ID)
        return collectionView
    }()
    
    private lazy var tap: UITapGestureRecognizer = {
        let tap = UITapGestureRecognizer(target: self, action: #selector(tappedAroundOfCollectionView))
        tap.cancelsTouchesInView = false
        return tap
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension OZPhotoGalleryView {
    
    func setupUI() {
        self.backgroundColor = .black.withAlphaComponent(0.75)
        
        setupContentCollectionView()
        configureCollectionView()
        setupContentCollectionView()
        setupGestureRecognizers()
    }
    
    func setupGestureRecognizers() {
        self.addGestureRecognizer(tap)
    }
    
    func setupContentCollectionView() {
        self.addSubview(contentCollectionView)
        let resolution9x16: Float = 9/16
        
        contentCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(contentCollectionView.snp.width).multipliedBy(resolution9x16)
            make.center.equalToSuperview()
        }
    }
    
    func configureCollectionView() {
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = CGSize(width: UIScreen.main.bounds.width,
                                         height: UIScreen.main.bounds.width*9/16)
        carouselLayout.sectionInset = .zero
        carouselLayout.minimumInteritemSpacing = 0
        carouselLayout.minimumLineSpacing = 0
        contentCollectionView.collectionViewLayout = carouselLayout
        contentCollectionView.reloadData()
    }
    
    
}


private extension OZPhotoGalleryView {
    
    @objc func tappedAroundOfCollectionView() {
        self.removeFromSuperview()
    }
    
    
}


extension OZPhotoGalleryView {
    
    func configureView(imageLinks imageURLList: [URL], currentItem: Int) {
        self.numberOfPages = imageURLList.count
        self.imageURLList = imageURLList
        self.contentCollectionView.scrollToItem(at: IndexPath(item: currentItem, section: 0), at: .top, animated: false)
    }
    
    
}


extension OZPhotoGalleryView: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return numberOfPages
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OZPhotoGalleryViewCollectionViewCell.ID, for: indexPath) as! OZPhotoGalleryViewCollectionViewCell
        cell.configureCell(imageLink: imageURLList[indexPath.row])
        return cell
    }
    
    
}

extension OZPhotoGalleryView: UICollectionViewDelegate {
    
}
