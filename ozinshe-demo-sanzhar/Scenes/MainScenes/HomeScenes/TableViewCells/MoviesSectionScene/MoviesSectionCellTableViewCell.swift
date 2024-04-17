//
//  GalleryListTableViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import UIKit
import SnapKit
import SkeletonView


// MARK: - Protocol: MoviesSectionCellTableViewCellDelegate

protocol MoviesSectionCellTableViewCellDelegate {
    func moviesSectionCell(didTapMovie movie: MovieWithDetails)
    func moviesSectionCell(tappedMoreForContent moviesSection: MoviesSection)
}


class MoviesSectionCellTableViewCell: UITableViewCell {
    
    // MARK: - Public variables
    
    static let ID: String = "MoviesSectionCellTableViewCell"
    var delegate: MoviesSectionCellTableViewCellDelegate?
    
    
    // MARK: - Internal variables
    
    private var moviesSection: MoviesSection = MoviesSection() {
        didSet {
            itemsCount = moviesSection.movies.count
            chapterTitleLabel.text = moviesSection.categoryName
            contentCollectionView.reloadData()
        }
    }
    private var itemsCount = 5
    
    
    // MARK: - UI Elements
    
    private lazy var chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "GalleryList-TVProgram".localized()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = Style.Colors.label
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        return label
    }()
    
    private lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle("Movie-More".localized(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(Style.StaticColors.purple300, for: .normal)
        button.contentVerticalAlignment = .top
        button.addTarget(self, action: #selector(moreTapped(_:)), for: .touchUpInside)
        button.isSkeletonable = true
        button.isHiddenWhenSkeletonIsActive = true
        return button
    }()
    
    private lazy var contentCollectionView: UICollectionView = {
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
        
        collectionView.register(MoviesSectionCellCollectionViewCell.self,
                                forCellWithReuseIdentifier: MoviesSectionCellCollectionViewCell.ID)
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

private extension MoviesSectionCellTableViewCell {
    
    func setupUI() {
        self.backgroundColor = .clear
        self.isSkeletonable = true
        self.selectionStyle = .none
        
        setupChapterTitleLabel()
        setupMoreButton()
        setupContentCollectionView()
    }
    
    func setupChapterTitleLabel() {
        self.contentView.addSubview(chapterTitleLabel)
        
        chapterTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.equalToSuperview().inset(24)
            make.right.equalToSuperview().inset(112)
        }
    }
    
    func setupMoreButton() {
        self.contentView.addSubview(moreButton)
        
        moreButton.snp.makeConstraints { make in
            make.top.right.equalToSuperview()
            make.width.equalTo(112) // 112 is a specific width for aligning button title label to 24px from right side of superview
            make.bottom.equalTo(chapterTitleLabel)
        }
    }
    
    func setupContentCollectionView() {
        self.contentView.addSubview(contentCollectionView)
        
        contentCollectionView.snp.makeConstraints { make in
            make.top.equalTo(chapterTitleLabel.snp.bottom).inset(-16)
            make.left.right.bottom.equalToSuperview()
            make.height.equalTo(224)
        }
    }
    
    
}


// MARK: - Targets

private extension MoviesSectionCellTableViewCell {
    
    @objc func moreTapped(_ sender: UIButton) {
        delegate?.moviesSectionCell(tappedMoreForContent: moviesSection)
    }
    
    
}


// MARK: - External functions

extension MoviesSectionCellTableViewCell {
    
    func configureCell(_ moviesSection: MoviesSection) {
        self.moviesSection = moviesSection
    }
    
    func localizeCell() {
        self.chapterTitleLabel.text = "GalleryList-TVProgram".localized()
        self.moreButton.setTitle("Movie-More".localized(), for: .normal)
    }
    
    func showSkeletonWithAnimation() {
        self.showAnimatedGradientSkeleton(animation: DEFAULT_ANIMATION)
    }
    
    func hideSkeletonAnimation() {
        self.hideSkeleton()
    }
    
    
}


// MARK: - CollectionViewDataSource

extension MoviesSectionCellTableViewCell: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MoviesSectionCellCollectionViewCell.ID, for: indexPath) as! MoviesSectionCellCollectionViewCell
        if !moviesSection.movies.isEmpty {
            cell.configureCell(movie: moviesSection.movies[indexPath.row])
        }
        return cell
    }
    
    
}


// MARK: - CollectionViewDelegate

extension MoviesSectionCellTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) is MoviesSectionCellCollectionViewCell {
            delegate?.moviesSectionCell(didTapMovie: moviesSection.movies[indexPath.row])
        }
    }
    
    
}

