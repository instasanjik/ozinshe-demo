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
    
    private var category: MovieCategory?
    private var movieList: [MovieWithDetails] = []
    private var moviesSection: MoviesSection?
    
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


private extension MovieListViewController {
    
    func setupUI() {
        view.backgroundColor = Style.Colors.background
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.ID)
    }
    
    
}

private extension MovieListViewController {
    
    func downloadMovieList() {
        guard let category = category else { return }
        CoreService.Worker.getMovieListFromCategory(categoryID: category.id) { success, errorMessage, movieList in
            self.movieList = movieList
            self.tableView.reloadData()
        }
    }
    
    
}


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
    
    
}
