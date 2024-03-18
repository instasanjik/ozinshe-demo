//
//  SeriesViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 17.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

class SeriesViewController: UIViewController {
    
    var selectedSeasonIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    lazy var seasonsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = true
        
        collectionView.register(SeasonCollectionViewCell.self,
                                forCellWithReuseIdentifier: SeasonCollectionViewCell.ID)
        
        collectionView.isSkeletonable = true
        return collectionView
    }()
    
    lazy var seriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .clear
//        tableView.separatorStyle = .none
        
        tableView.register(SeriesTableViewCell.self,
                           forCellReuseIdentifier: SeriesTableViewCell.ID)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.Colors.background
        
        setupSeasonsCollectionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        seasonsCollectionView.selectItem(at: selectedSeasonIndexPath, animated: true, scrollPosition: .top)
    }
    
    
}


extension SeriesViewController {
    
    fileprivate func setupSeasonsCollectionView() {
        view.addSubview(seasonsCollectionView)
        
        seasonsCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(34)
            make.top.equalToSuperview().inset(100)
        }
    }
    
    
}


extension SeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonCollectionViewCell.ID, for: indexPath)
        if indexPath == selectedSeasonIndexPath {
            cell.isSelected = true
            Logger.log(.success, "\(indexPath)")
        } else {
            cell.isSelected = false
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = "1 сезон"
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.sizeToFit()
        return CGSize(width: label.frame.width + (16 * 2), height: 34)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedSeasonIndexPath != indexPath {
            selectedSeasonIndexPath = indexPath
        }
    }
    
    
}


extension SeriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        <#code#>
    }
    
    
}
