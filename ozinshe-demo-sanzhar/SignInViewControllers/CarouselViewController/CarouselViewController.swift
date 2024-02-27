//
//  ViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 26.02.2024.
//

import UIKit
import SnapKit


class CarouselViewController: UIViewController {
    
    lazy var carouselCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.cellId)
        return collectionView
    }()
    
    let carouselData = [
        "carouselItem-1",
        "carouselItem-2",
        "carouselItem-3",
    ]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Style.Colors.background
        
        setupCarousel()
    }
    
    
}

// MARK: UI setups
extension CarouselViewController {
    
    private func setupCarousel() {
        view.addSubview(carouselCollectionView)
        
        carouselCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        configureCollectionView()
    }
    
    
}

// MARK: CollectionView fucntions

extension CarouselViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    private func configureCollectionView() {
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = .init(width: Screen.width, height: Screen.height)
        carouselLayout.sectionInset = .zero
        carouselLayout.minimumInteritemSpacing = 0
        carouselLayout.minimumLineSpacing = 0
        carouselCollectionView.collectionViewLayout = carouselLayout
        carouselCollectionView.reloadData()
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.cellId, for: indexPath) as? CarouselCell else { return UICollectionViewCell() }
        cell.configure(carouselData[indexPath.row])
        return cell
    }
    
    
}
