//
//  KeepWatchingTableViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

protocol KeepWatchingTableViewCellDelegate: AnyObject {
    func keepWatching(didTapMovie movie: MovieWithDetails)
}

class KeepWatchingTableViewCell: UITableViewCell {
    
    static let ID: String = "KeepWatchingTableViewCell"
    
    var keepWatchingMovieList: [MovieWithDetails] = [] {
        didSet {
            itemsCount = keepWatchingMovieList.count
            print(itemsCount)
            contentCollectionView.reloadData()
        }
    }
    
    var itemsCount = 5
    
    var delegate: KeepWatchingTableViewCellDelegate?
    
    lazy var chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("KeepWatching-KeepWatching", comment: "Қарауды жалғастырыңыз")
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = Style.Colors.label
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        return label
    }()
    
    lazy var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.itemSize = CGSizeMake(184, 152)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.isSkeletonable = true
        
        collectionView.register(KeepWatchingCollectionViewCell.self,
                                forCellWithReuseIdentifier: KeepWatchingCollectionViewCell.ID)
        return collectionView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        
        backgroundColor = .clear
        setupChapterTitleLabel()
        setupContentCollectionView()
        
        self.isSkeletonable = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}


// MARK: UI Setups
extension KeepWatchingTableViewCell {
    
    private func setupChapterTitleLabel() {
        self.contentView.addSubview(chapterTitleLabel)
        
        chapterTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(24)
        }
    }
    
    private func setupContentCollectionView() {
        self.contentView.addSubview(contentCollectionView)
        
        contentCollectionView.snp.makeConstraints { make in
            make.top.equalTo(chapterTitleLabel.snp.bottom).inset(-16)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    
}


extension KeepWatchingTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KeepWatchingCollectionViewCell.ID, for: indexPath) as! KeepWatchingCollectionViewCell
        if !keepWatchingMovieList.isEmpty {
            cell.configureCell(movie: keepWatchingMovieList[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? KeepWatchingCollectionViewCell {
            delegate?.keepWatching(didTapMovie: keepWatchingMovieList[indexPath.row])
        }
    }
    
    
}

extension KeepWatchingTableViewCell {
    
    public func showSkeletonWithAnimation() {
        self.showAnimatedGradientSkeleton(animation: DEFAULT_ANIMATION)
    }
    
    public func hideSkeletonAnimation() {
        self.hideSkeleton()
    }
    
    
}
