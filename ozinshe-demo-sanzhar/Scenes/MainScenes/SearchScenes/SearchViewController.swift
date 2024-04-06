//
//  SearchViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 11.03.2024.
//

import UIKit
import SnapKit

/// View controller responsible for searching and displaying movie categories.
class SearchViewController: UIViewController {
    
    // MARK: - Variables
    
    /// Array to hold movie categories.
    private var categories: [MovieCategory] = [] {
        didSet {
            self.categoriesCount = categories.count
            self.categoriesCollectionView.reloadData()
        }
    }
    
    /// Count of categories initially set to 10.
    private var categoriesCount = 10
    
    
    // MARK: - UI Elements
    
    /// Text field for searching movies.
    private lazy var searchTextField: OZTextField = {
        let textField = OZTextField()
        textField.placeholder = NSLocalizedString("Search-Search", comment: "Іздеу")
        textField.padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        textField.normalBorderColor = UIColor.clear.cgColor
        let _ = textField.resignFirstResponder()
        textField.backgroundColor = Style.Colors.gray800
        return textField
    }()
    
    /// Button to trigger the search action.
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Style.Colors.gray700
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.layer.cornerRadius = 12
        button.tintColor = Style.Colors.white
        return button
    }()
    
    /// Label displaying general categories.
    private lazy var categoriesLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("General-Categories", comment: "Санаттар")
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.label
        return label
    }()
    
    /// Collection view to display movie categories.
    private lazy var categoriesCollectionView: UICollectionView = {
        let layout = LeftAlignedCollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24.0, bottom: 0, right: 24.0)
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 16
        layout.estimatedItemSize.width = 100
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        collectionView.register(ContentCategoryCollectionViewCell.self,
                                forCellWithReuseIdentifier: ContentCategoryCollectionViewCell.ID)
        return collectionView
    }()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        downloadData()
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


// MARK: - UI Setups

fileprivate extension SearchViewController {
    
    /// Sets up the initial UI components.
    func setupUI() {
        view.backgroundColor = Style.Colors.background
        
        setupSearchTextField()
        setupSearchButton()
        setupCategoriesLabel()
        setupCategoriesCollectionView()
    }
    
    /// Configures search text field.
    func setupSearchTextField() {
        view.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(56)
        }
    }
    
    /// Configures search button.
    func setupSearchButton() {
        view.addSubview(searchButton)
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(searchTextField)
            make.left.equalTo(searchTextField.snp.right).inset(-16)
            make.right.equalToSuperview().inset(24)
            make.height.width.equalTo(searchTextField.snp.height)
        }
    }
    
    /// Configures categories label.
    func setupCategoriesLabel() {
        view.addSubview(categoriesLabel)
        
        categoriesLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).inset(-36)
            make.left.equalTo(searchTextField)
        }
    }
    
    /// Configures categories collection view.
    func setupCategoriesCollectionView() {
        view.addSubview(categoriesCollectionView)
        
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoriesLabel.snp.bottom).inset(-16)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
}


// MARK: - Internal functions

fileprivate extension SearchViewController {
    
    /// Downloads categories data from the server.
    func downloadData() {
        CoreService.Worker.getCategories { success, errorMessage, categories in
            self.categories = categories
        }
    }
    
    func openCategorieMovieListViewController(category: MovieCategory) {
        let vc = MovieListViewController()
        vc.configureScene(category: category)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


// MARK: - Delegates

// MARK: CollectionViewDelegate

extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openCategorieMovieListViewController(category: categories[indexPath.row])
        collectionView.deselectItem(at: indexPath, animated: true)
    }
    
    
}

// MARK: CollecitonViewData Source

extension SearchViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoriesCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ContentCategoryCollectionViewCell.ID, for: indexPath) as! ContentCategoryCollectionViewCell
        if !categories.isEmpty {
            cell.configureCell(categoryName: categories[indexPath.row].name)
        }
        return cell
    }
    
    
}

// MARK: CollectionViewDelegateFlowLayout

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        if categories.isEmpty {
            label.text = "SPLASH_TEXT"
        } else {
            label.text = categories[indexPath.row].name
        }
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.sizeToFit()
        return CGSize(width: label.frame.width + (16 * 2), height: 34)
    }
    
    
}
