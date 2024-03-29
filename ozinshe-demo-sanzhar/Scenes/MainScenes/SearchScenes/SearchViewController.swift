//
//  SearchViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 11.03.2024.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController {
    
    lazy var searchTextField: OZTextField = {
        let textField = OZTextField()
        textField.placeholder = "Поиск"
        textField.padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        textField.normalBorderColor = UIColor.clear.cgColor
        let _ = textField.resignFirstResponder()
        textField.backgroundColor = Style.Colors.gray800
        return textField
    }()
    
    lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Style.Colors.gray700
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.layer.cornerRadius = 12
        button.tintColor = Style.Colors.white
        return button
    }()
    
    lazy var categoriesLabel: UILabel = {
        let label = UILabel()
        label.text = "Санаттар"
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.label
        return label
    }()
    
    lazy var categoriesCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24.0, bottom: 0, right: 24.0)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize.width = 100
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
//        coll
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(ContentCategoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: ContentCategoryCollectionViewCell.ID)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.Colors.background
        
        setupSearchTextField()
        setupSearchButton()
        setupCategoriesLabel()
        setupCategoriesCollectionView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
}


extension SearchViewController {
    
    fileprivate func setupSearchTextField() {
        view.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(56)
        }
    }
    
    fileprivate func setupSearchButton() {
        view.addSubview(searchButton)
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(searchTextField)
            make.right.equalToSuperview().inset(24)
            make.left.equalTo(searchTextField.snp.right).inset(-16)
            make.height.width.equalTo(searchTextField.snp.height)
        }
    }
    
    fileprivate func setupCategoriesLabel() {
        view.addSubview(categoriesLabel)
        
        categoriesLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).inset(-36)
            make.left.equalTo(searchTextField)
        }
    }
    
    fileprivate func setupCategoriesCollectionView() {
        view.addSubview(categoriesCollectionView)
        
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoriesLabel.snp.bottom).inset(-16)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
}


extension SearchViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return StaticData.contentCategories.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCategoryCollectionViewCell.ID, for: indexPath) as! ContentCategoryCollectionViewCell
        cell.contentCategoryLabel.text = StaticData.contentCategories[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        label.text = StaticData.contentCategories[indexPath.row]
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.sizeToFit()
        return CGSize(width: label.frame.width + (16 * 2), height: 34)
    }
    
    
}
    

class LeftAlignedCollectionViewFlowLayout: UICollectionViewFlowLayout {

    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        let attributes = super.layoutAttributesForElements(in: rect)

        var leftMargin = sectionInset.left
        var maxY: CGFloat = -1.0
        attributes?.forEach { layoutAttribute in
            guard layoutAttribute.representedElementCategory == .cell else {
                return
            }
            if layoutAttribute.frame.origin.y >= maxY {
                leftMargin = sectionInset.left
            }

            layoutAttribute.frame.origin.x = leftMargin

            leftMargin += layoutAttribute.frame.width + minimumInteritemSpacing
            maxY = max(layoutAttribute.frame.maxY , maxY)
        }

        return attributes
    }
}
