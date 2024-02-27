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
    
    lazy var continueButton: OZButton = {
        let button = OZButton()
        button.titleText = NSLocalizedString("carouselContinueButtonText", comment: "Әрі қарай")
        return button
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
        setupButton()
    }
    
    
}

// MARK: UI setups
extension CarouselViewController {
    
    private func setupCarousel() {
        view.addSubview(carouselCollectionView)
        configureCollectionView()
        
        carouselCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func setupButton() {
        view.addSubview(continueButton)
        
        continueButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(38)
        }
    }
    
    
}


// MARK: CollectionView functions
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


