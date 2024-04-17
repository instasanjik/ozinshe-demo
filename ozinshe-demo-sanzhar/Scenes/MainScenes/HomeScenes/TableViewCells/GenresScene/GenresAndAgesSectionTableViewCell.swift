//
//  GenresAndAgesSectionTableViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 13.03.2024.
//

import UIKit
import SnapKit


// MARK: - Protocol: GenresAndAgesSectionTableViewCellDelegate

protocol GenresAndAgesSectionTableViewCellDelegate {
    func genresAndAgesSection(didTapSection section: ContentCategory)
}


class GenresAndAgesSectionTableViewCell: UITableViewCell {
    
    // MARK: - Public variables
    
    static let ID: String = "MovieCardTableViewCell"
    var delegate: GenresAndAgesSectionTableViewCellDelegate?
    
    
    // MARK: - Internal variables
    
    private var content: [ContentCategory] = [] {
        didSet {
            itemsCount = content.count
            contentCollectionView.reloadData()
        }
    }
    private var itemsCount = 5
    
    
    // MARK: - UI Elements
    
    private lazy var chapterTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "MovieInfo-Trending".localized()
        label.font = .systemFont(ofSize: 16, weight: .bold)
        label.textColor = Style.Colors.label
        return label
    }()
    
    private lazy var contentCollectionView: UICollectionView = {
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

private extension GenresAndAgesSectionTableViewCell {
    
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
            make.height.equalTo(224)
        }
    }
    
    
}


// MARK: - External functions

extension GenresAndAgesSectionTableViewCell {
    
    func configureCell(content: [ContentCategory]) {
        self.content = content
    }
    
    func localizeCell() {
        self.chapterTitleLabel.text = "MovieInfo-Trending".localized()
        self.contentCollectionView.reloadData()
        
        self.contentCollectionView.visibleCells.forEach { cell in
            if let cell = cell as? GenresAndAgesCollectionViewCell {
                cell.localizeCell()
            }
        }
    }
    
    
}


// MARK: - CollectionViewDataSource

extension GenresAndAgesSectionTableViewCell: UICollectionViewDataSource {
    
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
    
    
}



// MARK: - CollectionViewDelegate

extension GenresAndAgesSectionTableViewCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView.cellForItem(at: indexPath) is GenresAndAgesCollectionViewCell {
            delegate?.genresAndAgesSection(didTapSection: content[indexPath.row])
        }
    }
    
    
}

