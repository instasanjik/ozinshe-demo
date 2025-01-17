//
//  KeepWatchingTableViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import UIKit
import SnapKit


// MARK: - Protocol: KeepWatchingTableViewCellDelegate

protocol KeepWatchingTableViewCellDelegate: AnyObject {
    func keepWatching(didTapMovie movie: MovieWithDetails)
}


class KeepWatchingTableViewCell: UITableViewCell {
    
    // MARK: - Public variables
    
    static let ID: String = "KeepWatchingTableViewCell"
    var delegate: KeepWatchingTableViewCellDelegate?
    
    
    // MARK: - Internal variables
    
    private var keepWatchingMovieList: [MovieWithDetails] = [] {
        didSet {
            itemsCount = keepWatchingMovieList.count
            contentCollectionView.reloadData()
        }
    }
    private var itemsCount = 5 // default value for showing skeleton
    
    
    // MARK: - UI Elements
    
    private lazy var chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "KeepWatching-KeepWatching".localized()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = Style.Colors.label
        return label
    }()
    
    private lazy var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.itemSize = CGSizeMake(184, 152)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(KeepWatchingCollectionViewCell.self,
                                forCellWithReuseIdentifier: KeepWatchingCollectionViewCell.ID)
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

private extension KeepWatchingTableViewCell {
    
    func setupUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
        
        setupChapterTitleLabel()
        setupContentCollectionView()
    }
    
    func setupChapterTitleLabel() {
        self.contentView.addSubview(chapterTitleLabel)
        
        chapterTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(24)
        }
    }
    
    func setupContentCollectionView() {
        self.contentView.addSubview(contentCollectionView)
        
        contentCollectionView.snp.makeConstraints { make in
            make.top.equalTo(chapterTitleLabel.snp.bottom).inset(-16)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    
}


// MARK: - External functions

extension KeepWatchingTableViewCell {
    
    func configureCell(_ keepWatchingMovieList: [MovieWithDetails]) {
        self.keepWatchingMovieList = keepWatchingMovieList
    }
    
    func localizeCell() {
        self.chapterTitleLabel.text = "KeepWatching-KeepWatching".localized()
    }
    
    
}


// MARK: - CollectionViewDataSource

extension KeepWatchingTableViewCell: UICollectionViewDataSource {
    
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
    
    
}


// MARK: - CollectionViewDelegate

extension KeepWatchingTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.keepWatching(didTapMovie: keepWatchingMovieList[indexPath.row])
    }
    
    
}
