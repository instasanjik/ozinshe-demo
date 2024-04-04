//
//  HomeViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 11.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

class HomeViewController: UIViewController {
    
    var bannersList: [MovieBanner] = []
    var keepWathingMoviesList: [MovieWithDetails] = []
    var genresList: [AgeAndGenreCardContent] = []
    var agesList: [AgeAndGenreCardContent] = []
    var moviesSectionsList: [MoviesSection] = [] {
        didSet {
            moviesSectionsList.insert(MoviesSection(), at: 0) // instead of header
            moviesSectionsList.insert(MoviesSection(), at: 1) // instead of keep watching
            if moviesSectionsList.count >= 2 {
                genresSectionPositionInTableView = 4
                moviesSectionsList.insert(MoviesSection(), at: 4) // instead of genres
                agesSectionPositionInTableView = 5
                moviesSectionsList.insert(MoviesSection(), at: 5) // instead of age categories
            }
            if moviesSectionsList.count >= 5 {
                moviesSectionsList.remove(at: 5) // removing old object of age categories
                agesSectionPositionInTableView = 8
                moviesSectionsList.insert(MoviesSection(), at: 8) // instead of age categories
            }
        }
    }
    
    var numverOfSectionInTableView = 4
    var genresSectionPositionInTableView = 2
    var agesSectionPositionInTableView = 27
    
    
    lazy var mainTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .clear
        tableView.separatorStyle = .none
        
        tableView.register(HeaderTableViewCell.self,
                           forCellReuseIdentifier: HeaderTableViewCell.ID)
        tableView.register(KeepWatchingTableViewCell.self, 
                           forCellReuseIdentifier: KeepWatchingTableViewCell.ID)
        tableView.register(MoviesSectionCellTableViewCell.self,
                           forCellReuseIdentifier: MoviesSectionCellTableViewCell.ID)
        tableView.register(GenresAndAgesSectionTableViewCell.self,
                           forCellReuseIdentifier: GenresAndAgesSectionTableViewCell.ID)
        
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.Colors.background
        
        setupTableView()
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


// MARK: UI Setups
extension HomeViewController {
    
    private func setupTableView() {
        view.addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
}


// MARK: Server communication
extension HomeViewController {
    
    fileprivate func downloadData() {
        showTableViewCellsSkeleton()
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        CoreService.Worker.getMoviesCells { success, errorMessage, moviesSectionsList in
            defer {
                dispatchGroup.leave()
            }
            if success {
                self.moviesSectionsList = moviesSectionsList
                self.numverOfSectionInTableView += moviesSectionsList.count
            } else {
                // Handle error
            }
        }
        
        dispatchGroup.enter()
        CoreService.Worker.getBanners { success, errorMessage, bannersList in
            defer {
                dispatchGroup.leave()
            }
            if success {
                self.bannersList = bannersList
            } else {
                // Handle error
            }
        }
        
        dispatchGroup.enter()
        CoreService.Worker.getKeepWatchingMovies { success, errorMessage, keepWatchingMovieLists in
            defer {
                dispatchGroup.leave()
            }
            if success {
                self.keepWathingMoviesList = keepWatchingMovieLists
            } else {
                // Handle error
            }
        }
        
        dispatchGroup.enter()
        CoreService.Worker.getGenres { success, errorMessage, genresList in
            defer {
                dispatchGroup.leave()
            }
            if success {
                self.genresList = genresList
            } else {
                // Handle error
            }
        }
        
        dispatchGroup.enter()
        CoreService.Worker.getAgeCategories { success, errorMessage, ageCaregoriesList in
            defer {
                dispatchGroup.leave()
            }
            if success {
                self.agesList = ageCaregoriesList
            } else {
                // Handle error
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            self.hideTableViewCellsSkeleton()
            self.mainTableView.reloadData()
        }
    }

    
    
}


// MARK: Triggers
extension HomeViewController {
    
    fileprivate func showTableViewCellsSkeleton() {
        if let cell = mainTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? HeaderTableViewCell {
            cell.showSkeletonWithAnimation()
        }
        if let cell = mainTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? KeepWatchingTableViewCell {
            cell.showSkeletonWithAnimation()
        }
        if let cell = mainTableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? MoviesSectionCellTableViewCell {
            cell.showSkeletonWithAnimation()
        }
        mainTableView.isScrollEnabled = false
    }
    
    fileprivate func hideTableViewCellsSkeleton() {
        if let cell = mainTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? HeaderTableViewCell {
            cell.hideSkeletonAnimation()
        }
        if let cell = mainTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as? KeepWatchingTableViewCell {
            cell.hideSkeletonAnimation()
        }
        if let cell = mainTableView.cellForRow(at: IndexPath(row: 0, section: 2)) as? MoviesSectionCellTableViewCell {
            cell.hideSkeletonAnimation()
        }
        mainTableView.isScrollEnabled = true
    }
    
    fileprivate func openMovieViewController(with movie: MovieWithDetails) {
        let vc = MovieInfoViewController()
        

        vc.configureScene(content: movie,
                          similarTVSeries: movie.findSimilarTVSeries(moviesSectionsList: moviesSectionsList))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    fileprivate func openMovieListViewController(with content: AgeAndGenreCardContent) {
        print(content.name)
    }
    
    
    
}

// MARK: TableView Delegate and Datasource
extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return numverOfSectionInTableView
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.ID,
                                                 for: indexPath) as! HeaderTableViewCell
            cell.selectionStyle = .none
            cell.bannerList = bannersList
            cell.delegate = self
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: KeepWatchingTableViewCell.ID,
                                                 for: indexPath) as! KeepWatchingTableViewCell
            cell.selectionStyle = .none
            cell.keepWatchingMovieList = keepWathingMoviesList
            cell.delegate = self
            return cell
        case genresSectionPositionInTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: GenresAndAgesSectionTableViewCell.ID,
                                                     for: indexPath) as! GenresAndAgesSectionTableViewCell
            cell.selectionStyle = .none
            cell.content = genresList
            cell.delegate = self
            return cell
        case agesSectionPositionInTableView:
            let cell = tableView.dequeueReusableCell(withIdentifier: GenresAndAgesSectionTableViewCell.ID,
                                                     for: indexPath) as! GenresAndAgesSectionTableViewCell
            cell.selectionStyle = .none
            cell.content = agesList
            cell.delegate = self
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: MoviesSectionCellTableViewCell.ID,
                                                 for: indexPath) as! MoviesSectionCellTableViewCell
            cell.selectionStyle = .none
            cell.delegate = self
            if !moviesSectionsList.isEmpty {
                cell.moviesSection = moviesSectionsList[indexPath.section]
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: 
            return 328-20 // banners
        case 1:
            return 194 // keep watching
        case genresSectionPositionInTableView:
            return 150 // genres
        case agesSectionPositionInTableView: 
            return 150 // ages
        default: return 259
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
}

extension HomeViewController: HeaderTableViewCellDelegate {
    
    func headerCell(didTapMovie movie: MovieWithDetails) {
        self.openMovieViewController(with: movie)
    }
    
    
}

extension HomeViewController: KeepWatchingTableViewCellDelegate {
    
    func keepWatching(didTapMovie movie: MovieWithDetails) {
        self.openMovieViewController(with: movie)
    }
    
    
}

extension HomeViewController: MoviesSectionCellTableViewCellDelegate {
    
    func moviesSectionCell(didTapMovie movie: MovieWithDetails) {
        self.openMovieViewController(with: movie)
    }
    
    func moviesSectionCell(tappedMoreForContent moviesSection: MoviesSection) {
        print(moviesSection.categoryName)
    }
    
    
}

extension HomeViewController: GenresAndAgesSectionTableViewCellDelegate {
    
    func genresAndAgesSection(didTapSection section: AgeAndGenreCardContent) {
        self.openMovieListViewController(with: section)
    }
    
    
}
