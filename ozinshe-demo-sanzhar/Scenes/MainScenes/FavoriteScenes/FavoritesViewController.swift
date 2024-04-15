//
//  FavoritesViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 11.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

class FavoritesViewController: UITableViewController {
    
    // MARK: - UI Elements
    
    private var movieList: [MovieWithDetails] = [] {
        didSet {
            let shouldShow = !movieList.isEmpty
            errorLabel.isHidden = shouldShow
            errorBodyLabel.isHidden = shouldShow
            lookOutButton.isHidden = shouldShow
        }
    }
    
    private lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = Style.Colors.label
        label.text = "🙊 Oops... there is nothing!"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private lazy var errorBodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = Style.Colors.label
        label.text = "But you can fill it by adding sany movie to favorites!"
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private lazy var lookOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Style.Colors.gray800
        button.tintColor = Style.Colors.purple400
        button.layer.cornerRadius = 8
        button.isHidden = true
        
        button.setTitle("Look out!", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        button.setTitleColor(Style.Colors.purple400, for: .normal)
        
        button.addTarget(self, action: #selector(lookOutButtonTapped), for: .touchUpInside)
        
        return button
    }()

    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        downloadFavoritesList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
    }
    
}


// MARK: - UI Setups

private extension FavoritesViewController {
    
    func setupUI() {
        view.backgroundColor = Style.Colors.background
        
        navigationItem.title = "Favorites-Title".localized()
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.ID)
        
        setupErrorLabel()
        setupErrorBodyLabel()
        setupLookOutButton()
    }
    
    func setupErrorLabel() {
        self.tableView.addSubview(errorLabel)
        
        errorLabel.snp.makeConstraints { make in
            make.left.right.equalToSuperview().inset(48)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupErrorBodyLabel() {
        self.tableView.addSubview(errorBodyLabel)
        
        errorBodyLabel.snp.makeConstraints { make in
            make.top.equalTo(errorLabel.snp.bottom).inset(-16)
            make.left.right.equalToSuperview().inset(48)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupLookOutButton() {
        self.tableView.addSubview(lookOutButton)
        
        lookOutButton.snp.makeConstraints { make in
            make.top.equalTo(errorBodyLabel.snp.bottom).inset(-48)
            make.width.equalTo(124)
            make.height.equalTo(48)
            make.center.equalToSuperview()
        }
    }
    
    
}


// MARK: - Internal functions

private extension FavoritesViewController {
    
    func downloadFavoritesList() {
        CoreService.shared.getFavorites { success, errorMessage, favoritesList in
            self.movieList = favoritesList
            self.tableView.reloadData()
        }
    }
    
    func openMovieViewController(with movie: MovieWithDetails) {
        let vc = MovieInfoViewController()
        vc.configureScene(content: movie)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openHomeViewController() {
        self.tabBarController?.selectedIndex = 0
    }
    
    
}


// MARK: - Targers

extension FavoritesViewController {
    
    @objc func lookOutButtonTapped() {
        openHomeViewController()
    }
    
    
}


// MARK: - Delegates

// MARK: TableViewDataSource
extension FavoritesViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.ID, for: indexPath) as! MovieTableViewCell
        cell.configureCell(content: movieList[indexPath.row])
        return cell
    }
    
    
}


// MARK: TableViewDelegate
extension FavoritesViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openMovieViewController(with: movieList[indexPath.row])
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
