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
    
    // MARK: - Internal variables
    private var bannersList: [MovieBanner] = []
    private var keepWatchingMoviesList: [MovieWithDetails] = []
    private var genresList: [ContentCategory] = []
    private var agesList: [ContentCategory] = []
    private var isMoviesSectionsListEditing = false
    private var moviesSectionsList: [MoviesSection] = [] {
        didSet {
            insertStaticSections()
        }
    }
    private var genresSectionPositionInTableView = 2
    private var agesSectionPositionInTableView = 27
    
    
    // MARK: - UI Elements
    
    private lazy var mainTableView: UITableView = {
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

private extension HomeViewController {
    
    func setupUI() {
        view.backgroundColor = Style.Colors.background
        
        setupTableView()
    }
    
    func setupTableView() {
        view.addSubview(mainTableView)
        
        mainTableView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.left.right.equalToSuperview()
            make.bottom.equalToSuperview()
        }
    }
    
    
}


// MARK: - Internal functions

private extension HomeViewController {
    
    func downloadData() {
        showTableViewCellsSkeleton()
        let dispatchGroup = DispatchGroup()
        
        dispatchGroup.enter()
        CoreService.shared.getMoviesCells { success, errorMessage, moviesSectionsList in
            defer {
                dispatchGroup.leave()
            }
            if success {
                self.moviesSectionsList = moviesSectionsList
            } else {
                // Handle error
            }
        }
        
        dispatchGroup.enter()
        CoreService.shared.getBanners { success, errorMessage, bannersList in
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
        CoreService.shared.getKeepWatchingMovies { success, errorMessage, keepWatchingMovieLists in
            defer {
                dispatchGroup.leave()
            }
            if success {
                self.keepWatchingMoviesList = keepWatchingMovieLists
            } else {
                // Handle error
            }
        }
        
        dispatchGroup.enter()
        CoreService.shared.getGenres { success, errorMessage, genresList in
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
        CoreService.shared.getAgeCategories { success, errorMessage, ageCaregoriesList in
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
    
    func showTableViewCellsSkeleton() {
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
    
    func hideTableViewCellsSkeleton() {
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
    
    func openMovieViewController(with movie: MovieWithDetails) {
        let vc = MovieInfoViewController()
        
        
        vc.configureScene(content: movie,
                          similarTVSeries: movie.findSimilarTVSeries(moviesSectionsList: moviesSectionsList))
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func openMovieListViewController(with content: ContentCategory) {
        Logger.log(.info, content.name)
        // TODO: Make age and genres view controller open
    }
    
    
    func genresAndAgesSectionCell(for tableView: UITableView, indexPath: IndexPath, content: [ContentCategory]) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GenresAndAgesSectionTableViewCell.ID, for: indexPath) as! GenresAndAgesSectionTableViewCell
        cell.configureCell(content: content)
        cell.delegate = self
        return cell
    }
    
    func insertStaticSections() {
        guard !isMoviesSectionsListEditing else { return }
        isMoviesSectionsListEditing = true
        
        let cleanMoviesSections = moviesSectionsList
        var cleanMoviesSectionsIndex = 0
        var formattedSections = [MoviesSection]()
        
        formattedSections.append(MoviesSection()) // instead of header
        
        if !keepWatchingMoviesList.isEmpty {
            formattedSections.append(MoviesSection()) // instead of keep watching
        }
        
        while cleanMoviesSectionsIndex != 2 && cleanMoviesSectionsIndex < cleanMoviesSections.count {
            formattedSections.append(cleanMoviesSections[cleanMoviesSectionsIndex]) // adding movies sections for spacing
            cleanMoviesSectionsIndex += 1
        }
        
        formattedSections.append(MoviesSection()) // instead of genres
        genresSectionPositionInTableView = formattedSections.count - 1
        
        formattedSections.append(MoviesSection()) // instead of ages
        agesSectionPositionInTableView = formattedSections.count - 1
        
        
        while cleanMoviesSectionsIndex != 5 && cleanMoviesSectionsIndex < cleanMoviesSections.count {
            formattedSections.append(cleanMoviesSections[cleanMoviesSectionsIndex]) // adding movies sections for spacing
            cleanMoviesSectionsIndex += 1
        }
        
        formattedSections.remove(at: agesSectionPositionInTableView)
        formattedSections.append(MoviesSection()) // instead of ages
        agesSectionPositionInTableView = formattedSections.count - 1
        
        while cleanMoviesSectionsIndex < cleanMoviesSections.count {
            formattedSections.append(cleanMoviesSections[cleanMoviesSectionsIndex]) // adding movies sections for spacing
            cleanMoviesSectionsIndex += 1
        }
        
        moviesSectionsList = formattedSections
        isMoviesSectionsListEditing = false
    }
    
    
    
}


// MARK: - TableViewDelegate

extension HomeViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 308
        case 1:
            if keepWatchingMoviesList.isEmpty {
                return 259
            } else {
                return 194
            }
        case genresSectionPositionInTableView, agesSectionPositionInTableView:
            return 150
        default:
            return 259
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
}


// MARK: - TableViewDataSource

extension HomeViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return moviesSectionsList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.ID, for: indexPath) as! HeaderTableViewCell
            cell.selectionStyle = .none
            cell.configureCell(bannersList)
            cell.delegate = self
            return cell
            
        case 1:
            if !keepWatchingMoviesList.isEmpty {
                let cell = tableView.dequeueReusableCell(withIdentifier: KeepWatchingTableViewCell.ID, for: indexPath) as! KeepWatchingTableViewCell
                cell.configureCell(keepWatchingMoviesList)
                cell.delegate = self
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: MoviesSectionCellTableViewCell.ID, for: indexPath) as! MoviesSectionCellTableViewCell
                if !moviesSectionsList.isEmpty {
                    cell.configureCell(moviesSectionsList[indexPath.section])
                    cell.delegate = self
                }
                return cell
            }
            
        case genresSectionPositionInTableView:
            return genresAndAgesSectionCell(for: tableView, indexPath: indexPath, content: genresList)
            
        case agesSectionPositionInTableView:
            return genresAndAgesSectionCell(for: tableView, indexPath: indexPath, content: agesList)
            
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: MoviesSectionCellTableViewCell.ID, for: indexPath) as! MoviesSectionCellTableViewCell
            if !moviesSectionsList.isEmpty {
                cell.configureCell(moviesSectionsList[indexPath.section])
                cell.delegate = self
            }
            return cell
        }
    }
    
    
}


// MARK: - Content Cells Delegates
// MARK: HeaderTableViewCellDelegate
extension HomeViewController: HeaderTableViewCellDelegate {
    
    func headerCell(didTapMovie movie: MovieWithDetails) {
        self.openMovieViewController(with: movie)
    }
    
    
}


// MARK: KeepWatchingTableViewCellDelegate
extension HomeViewController: KeepWatchingTableViewCellDelegate {
    
    func keepWatching(didTapMovie movie: MovieWithDetails) {
        self.openMovieViewController(with: movie)
    }
    
    
}


// MARK: MoviesSectionCellTableViewCellDelegate
extension HomeViewController: MoviesSectionCellTableViewCellDelegate {
    
    func moviesSectionCell(didTapMovie movie: MovieWithDetails) {
        self.openMovieViewController(with: movie)
    }
    
    func moviesSectionCell(tappedMoreForContent moviesSection: MoviesSection) {
        let vc = MovieListViewController()
        vc.configureScene(moviesSection: moviesSection)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}


// MARK: GenresAndAgesSectionTableViewCellDelegate
extension HomeViewController: GenresAndAgesSectionTableViewCellDelegate {
    
    func genresAndAgesSection(didTapSection section: ContentCategory) {
        self.openMovieListViewController(with: section)
    }
    
    
}
