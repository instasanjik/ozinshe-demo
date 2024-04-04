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
    
    var moviesSection: MoviesSection?
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return moviesSection?.movies.count ?? 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.ID, for: indexPath) as! MovieTableViewCell
        if let moviesSection = moviesSection {
            cell.configureCell(content: moviesSection.movies[indexPath.row])
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

extension MovieListViewController {
    
    func configureScene(moviesSection section: MoviesSection) {
        self.title = section.categoryName
        self.moviesSection = section
    }
    
    
}
