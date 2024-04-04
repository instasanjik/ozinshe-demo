//
//  GalleryListTableViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

protocol MoviesSectionCellTableViewCellDelegate {
    func moviesSectionCell(didTapMovie movie: MovieWithDetails)
    func moviesSectionCell(tappedMoreForContent moviesSection: MoviesSection)
}

class MoviesSectionCellTableViewCell: UITableViewCell {
    
    static let ID: String = "MoviesSectionCellTableViewCell"
    
    var moviesSection: MoviesSection = MoviesSection() {
        didSet {
            itemsCount = moviesSection.movies.count
            chapterTitleLabel.text = moviesSection.categoryName
            contentCollectionView.reloadData()
        }
    }
    
    var itemsCount = 5
    
    var delegate: MoviesSectionCellTableViewCellDelegate?
    
    lazy var chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("GalleryList-TVProgram", comment: "Тв-бағдарлама және реалити-шоу")
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = Style.Colors.label
        label.isSkeletonable = true
        label.skeletonCornerRadius = 6
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Movie-More", comment: "Барлыгы"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(Style.StaticColors.purple300, for: .normal)
        button.contentVerticalAlignment = .top
        button.addTarget(self, action: #selector(moreTapped(_:)), for: .touchUpInside)
        button.isSkeletonable = true
        button.isHiddenWhenSkeletonIsActive = true
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
        
        collectionView.register(MoviesSectionCellCollectionViewCell.self,
                                forCellWithReuseIdentifier: MoviesSectionCellCollectionViewCell.ID)
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
extension MoviesSectionCellTableViewCell {
    
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


extension MoviesSectionCellTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? MoviesSectionCellCollectionViewCell {
            delegate?.moviesSectionCell(didTapMovie: moviesSection.movies[indexPath.row])
        }
    }
    
    
}

extension MoviesSectionCellTableViewCell {
    
    @objc func moreTapped(_ sender: UIButton) {
        delegate?.moviesSectionCell(tappedMoreForContent: moviesSection)
    }
    
    
}


extension MoviesSectionCellTableViewCell {
    
    public func showSkeletonWithAnimation() {
        self.showAnimatedGradientSkeleton(animation: DEFAULT_ANIMATION)
    }
    
    public func hideSkeletonAnimation() {
        self.hideSkeleton()
    }
    
    
}
