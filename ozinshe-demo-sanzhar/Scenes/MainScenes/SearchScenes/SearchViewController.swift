//
//  SearchViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 11.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

/// View controller responsible for searching and displaying movie categories.
class SearchViewController: UIViewController {
    
    // MARK: - Internal variables
    
    private var categories: [MovieCategory] = [] {
        didSet {
            self.categoriesCount = categories.count
            self.categoriesCollectionView.reloadData()
        }
    }
    private var searchResultMovieList: [MovieWithDetails] = [] {
        didSet {
            searchResultMovieCount = searchResultMovieList.count
        }
    }
    private var searchResultMovieCount = 0
    private var searchTimer: Timer?
    private let searchDelay: TimeInterval = 1.0
    private var isLoading = false {
        didSet {
            if isLoading {
                activityIndicator.startAnimating()
            } else {
                activityIndicator.stopAnimating()
            }
        }
    }
    private var categoriesCount = 10
    
    
    // MARK: - UI Elements
    
    private lazy var searchTextField: OZTextField = {
        let textField = OZTextField()
        textField.placeholder = NSLocalizedString("Search-Search", comment: "Іздеу")
        textField.padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        textField.normalBorderColor = UIColor.clear.cgColor
        let _ = textField.resignFirstResponder()
        textField.backgroundColor = Style.Colors.gray800
        textField.addTarget(self, action: #selector(searchTextFieldValueChanged(_:)), for: .editingChanged)
        return textField
    }()
    
    private lazy var searchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Style.Colors.gray700
        button.setImage(UIImage(systemName: "magnifyingglass"), for: .normal)
        button.layer.cornerRadius = 12
        button.tintColor = Style.Colors.white
        return button
    }()
    
    private lazy var categoriesLabel: UILabel = {
        let label = UILabel()
        label.text = NSLocalizedString("General-Categories", comment: "Санаттар")
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.label
        return label
    }()
    
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
    
    private lazy var searchResultTableView: UITableView = {
        let tableView = UITableView()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.ID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.isSkeletonable = true
        return tableView
    }()
    
    private lazy var noDataLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = Style.Colors.label
        label.text = "📭 Your search returned no results" // TODO: Localize
        label.textAlignment = .center
        label.isHidden = true
        return label
    }()
    
    private lazy var activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.color = .gray
        indicator.hidesWhenStopped = true
        return indicator
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

private extension SearchViewController {
    
    func setupUI() {
        view.backgroundColor = Style.Colors.background
        
        setupSearchTextField()
        setupSearchButton()
        setupCategoriesLabel()
        setupCategoriesCollectionView()
        setupSearchResultTableView()
        updateSearchState()
        setupNoResultsLabel()
        setupActivityIndicatorView()
    }
    
    func setupSearchTextField() {
        view.addSubview(searchTextField)
        
        searchTextField.snp.makeConstraints { make in
            make.top.left.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.height.equalTo(56)
        }
    }
    
    func setupSearchButton() {
        view.addSubview(searchButton)
        
        searchButton.snp.makeConstraints { make in
            make.top.equalTo(searchTextField)
            make.left.equalTo(searchTextField.snp.right).inset(-16)
            make.right.equalToSuperview().inset(24)
            make.height.width.equalTo(searchTextField.snp.height)
        }
    }
    
    func setupCategoriesLabel() {
        view.addSubview(categoriesLabel)
        
        categoriesLabel.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).inset(-36)
            make.left.equalTo(searchTextField)
        }
    }
    
    func setupCategoriesCollectionView() {
        view.addSubview(categoriesCollectionView)
        
        categoriesCollectionView.snp.makeConstraints { make in
            make.top.equalTo(categoriesLabel.snp.bottom).inset(-16)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    func setupSearchResultTableView() {
        view.addSubview(searchResultTableView)
        
        searchResultTableView.snp.makeConstraints { make in
            make.top.equalTo(searchTextField.snp.bottom).inset(-24)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupNoResultsLabel() {
        view.addSubview(noDataLabel)
        
        noDataLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.left.right.equalToSuperview().inset(48)
        }
    }
    
    func setupActivityIndicatorView() {
        view.addSubview(activityIndicator)
        
        activityIndicator.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    
    
}


// MARK: - Internal functions

private extension SearchViewController {
    
    func downloadData() {
        CoreService.shared.getCategories { success, errorMessage, categories in
            self.categories = categories
        }
    }
    
    func openCategorieMovieListViewController(category: MovieCategory) {
        let vc = MovieListViewController()
        vc.configureScene(category: category)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openMovieViewController(with movie: MovieWithDetails) {
        let vc = MovieInfoViewController()
        vc.configureScene(content: movie)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func sendSearchRequest(_ timer: Timer) {
        guard let searchText = searchTextField.text, !searchText.isEmpty else {
            resetSearchResults()
            return
        }
        
        CoreService.shared.searchByMovieName(movieName: searchText) { [self] success, errorMessage, resultList in
            self.searchResultMovieList = resultList
            self.noDataLabel.isHidden = searchTextField.text?.isEmpty ?? true || !searchResultMovieList.isEmpty
            
            self.searchResultTableView.reloadData()
            self.isLoading = false
        }
    }
    
    func updateSearchState() {
        let requestIsEmpty = searchTextField.text?.isEmpty ?? true
        noDataLabel.isHidden = true
        searchResultTableView.isHidden = requestIsEmpty
        isLoading = !requestIsEmpty
        categoriesLabel.isHidden = !requestIsEmpty
        categoriesCollectionView.isHidden = !requestIsEmpty
    }
    
    func resetSearchResults() {
        searchResultMovieList = []
        searchResultTableView.reloadData()
    }
    
    
}


// MARK: - Targets

private extension SearchViewController {
    
    @objc func searchTextFieldValueChanged(_ sender: UITextField!) {
        updateSearchState()
        searchTimer?.invalidate()
        
        searchTimer = Timer.scheduledTimer(timeInterval: searchDelay, target: self, selector: #selector(sendSearchRequest(_:)), userInfo: nil, repeats: false)
    }
    
    
}


// MARK: - Delegates

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


// MARK: CollectionViewDelegate
extension SearchViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        openCategorieMovieListViewController(category: categories[indexPath.row])
        collectionView.deselectItem(at: indexPath, animated: true)
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

// MARK: UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchResultMovieCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.ID, for: indexPath) as! MovieTableViewCell
        if !searchResultMovieList.isEmpty {
            cell.configureCell(content: searchResultMovieList[indexPath.row])
        }
        return cell
    }
    
    
}


// MARK: UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openMovieViewController(with: searchResultMovieList[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
