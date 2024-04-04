//
//  GenresAndAgesSectionTableViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import UIKit
import SnapKit

protocol GenresAndAgesSectionTableViewCellDelegate {
    func genresAndAgesSection(didTapSection section: AgeAndGenreCardContent)
}

class GenresAndAgesSectionTableViewCell: UITableViewCell {
    
    static let ID: String = "MovieCardTableViewCell"
    
    var content: [AgeAndGenreCardContent] = [] {
        didSet {
            itemsCount = content.count
            contentCollectionView.reloadData()
        }
    }
    var itemsCount = 5
    
    var delegate: GenresAndAgesSectionTableViewCellDelegate?
    
    lazy var chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("MovieInfo-Trending", comment: "Трендтегілер")
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = Style.Colors.label
        return label
    }()
    
    lazy var moreButton: UIButton = {
        let button = UIButton()
        button.setTitle(NSLocalizedString("Movie-More", comment: "Барлыгы"), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 14, weight: .semibold)
        button.setTitleColor(Style.StaticColors.purple300, for: .normal)
        button.contentVerticalAlignment = .top
        return button
    }()
    
    lazy var contentCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.itemSize = CGSizeMake(184, 112)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(GenresAndAgesCollectionViewCell.self,
                                forCellWithReuseIdentifier: GenresAndAgesCollectionViewCell.ID)
        return collectionView
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    
}


// MARK: UI Setups
extension GenresAndAgesSectionTableViewCell {
    
    fileprivate func setupUI() {
        setupChapterTitleLabel()
        setupMoreButton()
        setupContentCollectionView()
        
        backgroundColor = .clear
    }
    
    private func setupChapterTitleLabel() {
        self.contentView.addSubview(chapterTitleLabel)
        
        chapterTitleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(24)
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


// MARK: Collection View Delegates
extension GenresAndAgesSectionTableViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemsCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: GenresAndAgesCollectionViewCell.ID, for: indexPath) as! GenresAndAgesCollectionViewCell
        if !content.isEmpty {
            cell.configureCell(card: content[indexPath.row])
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let cell = collectionView.cellForItem(at: indexPath) as? GenresAndAgesCollectionViewCell {
            delegate?.genresAndAgesSection(didTapSection: content[indexPath.row])
        }
    }
    
    
}
