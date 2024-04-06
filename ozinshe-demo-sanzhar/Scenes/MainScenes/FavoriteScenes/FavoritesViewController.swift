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
    
    var movieList: [MovieWithDetails] = []
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return movieList.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MovieTableViewCell.ID, for: indexPath) as! MovieTableViewCell
        cell.configureCell(content: movieList[indexPath.row])
        return cell
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        downloadFavoritesList()
    }
    
}

private extension FavoritesViewController {
    
    func setupUI() {
        view.backgroundColor = Style.Colors.background
        
        navigationItem.title = NSLocalizedString("Favorites-Title", comment: "Избранное")
        tableView.register(MovieTableViewCell.self, forCellReuseIdentifier: MovieTableViewCell.ID)
    }
    
    
}


private extension FavoritesViewController {
    
    func downloadFavoritesList() {
        CoreService.Worker.getFavorites { success, errorMessage, favoritesList in
            self.movieList = favoritesList
            self.tableView.reloadData()
        }
    }
    
    
}
