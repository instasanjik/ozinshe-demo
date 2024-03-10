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
        button.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        button.titleText = NSLocalizedString("carouselContinueButtonText", comment: "Әрі қарай")
        return button
    }()
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentpage = currentPage
            if currentPage == carouselData.count - 1 {
                continueButton.titleText = NSLocalizedString("carouselEndButtonText", comment: "Әрі қарай")
            } else {
                continueButton.titleText = NSLocalizedString("carouselContinueButtonText", comment: "Әрі қарай")
            }
        }
    }
    
    private lazy var pageControl: OZPageControl = {
        let pageControl = OZPageControl(numberOfPages: 3, currentPage: 0, isCircular: true)
        return pageControl
    }()
    
    lazy var skipButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        button.backgroundColor = .white
        button.setTitle(NSLocalizedString("carouselSkipButton", comment: "Өткізу"),
                        for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
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
        setupContinueButton()
        setupPageControl()
        setupSkipButton()
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
    
    private func setupContinueButton() {
        view.addSubview(continueButton)
        
        continueButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(38)
        }
    }
    
    private func setupPageControl() {
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(continueButton.snp.top).offset(-24)
            make.width.equalTo(44)
            make.height.equalTo(6)
        }
    }
    
    private func setupSkipButton() {
        view.addSubview(skipButton)
        
        skipButton.snp.makeConstraints { make in
            make.width.greaterThanOrEqualTo(70)
            make.height.equalTo(24)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            make.right.equalToSuperview().inset(16)
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
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        currentPage = getCurrentPage()
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        currentPage = getCurrentPage()
    }
    
    
}

// MARK: Helpers
private extension CarouselViewController {
    func getCurrentPage() -> Int {
        
        let visibleRect = CGRect(origin: carouselCollectionView.contentOffset, size: carouselCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = carouselCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        
        return currentPage
    }
}

// MARK: Targets
private extension CarouselViewController {
    
    @objc func nextTapped(sender: UIButton!) {
        if currentPage + 1 < carouselData.count {
            carouselCollectionView.scrollToItem(at: IndexPath(item: currentPage + 1, section: 0) ,
                                                at: .top,
                                                animated: true)
        } else {
            print("Go to login page")
        }
    }
    
    @objc func skipTapped(sender: UIButton!) {
        print("Go to login page")
    }
    
    
}
