//
//  CarouselViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 26.02.2024.
//

import UIKit
import SnapKit

class CarouselViewController: UIViewController {
    
    // MARK: - Internal Variables
    
    private var currentPage = 0 {
        didSet {
            pageControl.currentpage = currentPage
            if currentPage == carouselData.count - 1 {
                continueButton.titleText = "carouselEndButtonText".localized()
            } else {
                continueButton.titleText = "carouselContinueButtonText".localized()
            }
        }
    }
    
    private let carouselData = [
        "carouselItem-1",
        "carouselItem-2",
        "carouselItem-3",
    ]
    
    
    // MARK: - UI Elements
    
    private lazy var pageControl: OZPageControl = {
        let pageControl = OZPageControl(numberOfPages: 3, currentPage: 0, isCircular: true)
        return pageControl
    }()
    
    private lazy var carouselCollectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        
        collectionView.register(CarouselCell.self, forCellWithReuseIdentifier: CarouselCell.cellId)
        return collectionView
    }()
    
    private lazy var continueButton: OZButton = {
        let button = OZButton()
        button.addTarget(self, action: #selector(nextTapped), for: .touchUpInside)
        button.titleText = "carouselContinueButtonText".localized()
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("carouselSkipButton".localized(), for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        
        button.backgroundColor = .white
        button.layer.cornerRadius = 8
        button.clipsToBounds = true
        
        button.addTarget(self, action: #selector(skipTapped), for: .touchUpInside)
        return button
    }()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    
}


// MARK: - UI Setups

private extension CarouselViewController {
    
    func setupUI() {
        view.backgroundColor = Style.Colors.background
        
        setupCarousel()
        setupContinueButton()
        setupPageControl()
        setupSkipButton()
    }
    
    func setupCarousel() {
        view.addSubview(carouselCollectionView)
        configureCollectionView()
        
        carouselCollectionView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func setupContinueButton() {
        view.addSubview(continueButton)
        
        continueButton.snp.makeConstraints { make in
            make.bottom.equalToSuperview().inset(38)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupPageControl() {
        view.addSubview(pageControl)
        
        pageControl.snp.makeConstraints { make in
            make.bottom.equalTo(continueButton.snp.top).offset(-24)
            make.centerX.equalToSuperview()
            make.height.equalTo(6)
            make.width.equalTo(44)
        }
    }
    
    func setupSkipButton() {
        view.addSubview(skipButton)
        
        skipButton.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).inset(16)
            make.right.equalToSuperview().inset(16)
            make.height.equalTo(24)
            make.width.greaterThanOrEqualTo(70)
        }
    }
    
    func configureCollectionView() {
        let carouselLayout = UICollectionViewFlowLayout()
        carouselLayout.scrollDirection = .horizontal
        carouselLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
        carouselLayout.sectionInset = .zero
        carouselLayout.minimumInteritemSpacing = 0
        carouselLayout.minimumLineSpacing = 0
        carouselCollectionView.collectionViewLayout = carouselLayout
        carouselCollectionView.reloadData()
    }
    
    
}


// MARK: - Targets

private extension CarouselViewController {
    
    @objc func nextTapped(sender: UIButton!) {
        if currentPage + 1 < carouselData.count {
            carouselCollectionView.scrollToItem(at: IndexPath(item: currentPage + 1, section: 0), at: .top, animated: true)
        } else {
            openLoginPage()
        }
    }
    
    @objc func skipTapped(sender: UIButton!) {
        openLoginPage()
    }
    
    
}


// MARK: - Internal functions

private extension CarouselViewController {
    
    func getCurrentPage() -> Int {
        let visibleRect = CGRect(origin: carouselCollectionView.contentOffset, size: carouselCollectionView.bounds.size)
        let visiblePoint = CGPoint(x: visibleRect.midX, y: visibleRect.midY)
        if let visibleIndexPath = carouselCollectionView.indexPathForItem(at: visiblePoint) {
            return visibleIndexPath.row
        }
        return currentPage
    }
    
    func openLoginPage() {
        let vc = SignInNavigationViewController()
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        present(vc, animated: true)
    }
    
    
}


// MARK: - CollectionViewDelegate

extension CarouselViewController: UICollectionViewDelegate {
    
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


// MARK: - CollectionViewDataSource

extension CarouselViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return carouselData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CarouselCell.cellId, for: indexPath) as? CarouselCell else { return UICollectionViewCell() }
        cell.configureCell(with: carouselData[indexPath.row])
        return cell
    }
    
    
}
