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
    
    // MARK: Variables
    private var movieList: [MovieWithDetails] = []

    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        downloadFavoritesList()
    }
    
}


// MARK: - UI Setups

private extension FavoritesViewController {
    
    func setupUI() {
        view.backgroundColor = Style.Colors.background
        
        navigationItem.title = NSLocalizedString("Favorites-Title", comment: "Избранное")
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.ID)
    }
    
    
}


// MARK: - Internal functions

private extension FavoritesViewController {
    
    func downloadFavoritesList() {
        CoreService.Worker.getFavorites { success, errorMessage, favoritesList in
            self.movieList = favoritesList
            self.tableView.reloadData()
        }
    }
    
    func openMovieViewController(with movie: MovieWithDetails) {
        let vc = MovieInfoViewController()
        

        vc.configureScene(content: movie)
        self.navigationController?.pushViewController(vc, animated: true)
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
