//
//  GalleryListTableViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

class GalleryListTableViewCell: UITableViewCell {
    
    static let ID: String = "GalleryListTableViewCell"
    
    lazy var chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Тв-бағдарлама және реалити-шоу"
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = Style.Colors.label
        label.numberOfLines = 2
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Барлыгы", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(Style.StaticColors.purple300, for: .normal)
        button.contentVerticalAlignment = .top
        return button
    }()
    
    lazy var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.itemSize = CGSizeMake(112, 219)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isSkeletonable = true
        
        collectionView.register(GalleryListCollectionViewCell.self,
                                forCellWithReuseIdentifier: GalleryListCollectionViewCell.ID)
        return collectionView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        backgroundColor = .clear
        setupChapterTitleLabel()
        setupMoreButton()
        setupContentCollectionView()
        
        self.isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}


// MARK: UI Setups
extension GalleryListTableViewCell {
    
    private func setupChapterTitleLabel() {
        self.contentView.addSubview(chapterTitleLabel)
        
        chapterTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(112)
        }
    }
    
    private func setupMoreButton() {
        self.contentView.addSubview(moreButton)
        
        moreButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.equalTo(112) // 112 is a specific width for aligning button title label to 24px from right side of superview
            make.bottom.equalTo(chapterTitleLabel)
        }
    }
    
    private func setupContentCollectionView() {
        self.contentView.addSubview(contentCollectionView)
        
        contentCollectionView.snp.makeConstraints { make in
            make.top.equalTo(chapterTitleLabel.snp.bottom).inset(-16)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(224)
        }
    }
    
    
}


extension GalleryListTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GalleryListCollectionViewCell.ID, for: indexPath)
        return cell
    }
    
    
}


extension GalleryListTableViewCell {
    
    public func showSkeletonWithAnimation() {
        contentCollectionView.showAnimatedGradientSkeleton(animation: DEFAULT_ANIMATION)
    }
    
    
}
