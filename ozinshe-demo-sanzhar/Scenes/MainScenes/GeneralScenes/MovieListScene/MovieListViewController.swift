//
//  MovieListViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 20.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

class MovieListViewController: UITableViewController {
    
    // MARK: - Internal variables
    
    private var category: MovieCategory?
    private var movieList: [MovieWithDetails] = []
    private var moviesSection: MoviesSection?
    private var movieContentCategory: ContentCategory?
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTabBarHidden(true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setTabBarHidden(false)
    }

    
}


// MARK: - UI Setups

private extension MovieListViewController {
    
    func setupUI() {
        view.backgroundColor = Style.Colors.background
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.ID)
    }
    
    
}


// MARK: - Internal functions

private extension MovieListViewController {
    
    func downloadMovieList() {
        if let category = category {
            CoreService.shared.getMovieListFromCategory(categoryID: category.id, categoryType: .movieCategory) { [weak self] success, errorMessage, movieList in
                self?.movieList = movieList
                self?.tableView.reloadData()
            }
        } else if let contentCategory = movieContentCategory {
            CoreService.shared.getMovieListFromCategory(categoryID: contentCategory.id, 
                                                        categoryType: contentCategory.isAgeCategory ? .ageCategory : .genreCategory) { [weak self] success, errorMessage, movieList in
                self?.movieList = movieList
                self?.tableView.reloadData()
            }
        }
    }
    
    func openMovieViewController(with movie: MovieWithDetails) {
        let vc = MovieInfoViewController()
        vc.configureScene(content: movie)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


// MARK: - External functions

extension MovieListViewController {
    
    func configureScene(moviesSection section: MoviesSection) {
        self.title = section.categoryName
        self.moviesSection = section
    }
    
    func configureScene(category: MovieCategory) {
        self.category = category
        self.title = category.name
        downloadMovieList()
    }
    
    func configureScene(contentCategory: ContentCategory) {
        self.movieContentCategory = contentCategory
        self.title = contentCategory.name
        downloadMovieList()
    }
    
    
}


// MARK: - Delegates

// MARK: UITableViewDataSource
extension MovieListViewController {
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesSection?.movies.count ?? movieList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.ID, for: indexPath) as! MovieTableViewCell
        if let moviesSection = moviesSection {
            cell.configureCell(content: moviesSection.movies[indexPath.row])
        } else if !movieList.isEmpty {
            cell.configureCell(content: movieList[indexPath.row])
        }
        return cell
    }
    
    
}


// MARK: UITableViewDelegate
extension MovieListViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let movie: MovieWithDetails
        if let moviesSection = moviesSection {
            movie = moviesSection.movies[indexPath.row]
        } else  {
            movie = movieList[indexPath.row]
        }
        openMovieViewController(with: movie)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
