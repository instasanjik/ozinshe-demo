//
//  SeriesViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 17.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

class SeriesViewController: UIViewController {
    
    // MARK: - Internal variables
    
    private var movieName: String = ""
    private var seasons: [Season] = [] {
        didSet {
            seasonsCollectionView.reloadData()
            seriesTableView.reloadData()
        }
    }
    private var seasonsCount = 0
    private var seriesCount = 10
    private var selectedSeasonIndexPath: IndexPath = IndexPath(item: 0, section: 0)
    
    
    // MARK: - UI Elements
    
    private lazy var seasonsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 24)
        layout.scrollDirection = .horizontal
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        collectionView.allowsSelection = true
        
        collectionView.register(SeasonCollectionViewCell.self,
                                forCellWithReuseIdentifier: SeasonCollectionViewCell.ID)
        
        collectionView.isSkeletonable = true
        return collectionView
    }()
    
    private lazy var seriesTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.backgroundColor = .clear
        tableView.contentInset = UIEdgeInsets(top: 0, left: 0, bottom: 24, right: 0)
        
        tableView.register(SeriesTableViewCell.self,
                           forCellReuseIdentifier: SeriesTableViewCell.ID)
        
        return tableView
    }()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setTabBarHidden(true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        seasonsCollectionView.selectItem(at: selectedSeasonIndexPath, animated: true, scrollPosition: .top)
    }
    
    
}


// MARK: - UI Setups

private extension SeriesViewController {
    
    func setupUI() {
        view.backgroundColor = Style.Colors.background
        view.showAnimatedGradientSkeleton(animation: DEFAULT_ANIMATION)
        
        setupSeasonsCollectionView()
        setupSeriesTableView()
    }
    
    func setupSeasonsCollectionView() {
        view.addSubview(seasonsCollectionView)
        
        seasonsCollectionView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.height.equalTo(34)
            make.top.equalToSuperview().inset(100)
        }
    }
    
    func setupSeriesTableView() {
        view.addSubview(seriesTableView)
        
        seriesTableView.snp.makeConstraints { make in
            make.top.equalTo(seasonsCollectionView.snp.bottom).inset(-24)
            make.left.right.bottom.equalToSuperview()
        }
    }
    
    
}

// MARK: - Internal functions

extension SeriesViewController {
    
    func openMoviePlayerViewController(selectedSeries: Int) {
        let vc = MoviePlayerViewController()
        vc.configureScene(seasons: self.seasons, movieName: self.movieName, selectedSeason: selectedSeasonIndexPath.row, selectedSeries: selectedSeries)
        vc.modalTransitionStyle = .crossDissolve
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true) {
            self.setTabBarHidden(true)
        }
    }
    
    
}


// MARK: - External functions

extension SeriesViewController {
    
    func configureScene(movie: MovieWithDetails) {
        self.movieName = movie.name
        CoreService.shared.getMovieSeasons(movieID: movie.id) { success, errorMessage, content in
            if success {
                self.seasons = content
                self.view.hideSkeleton()
            } else {
                Logger.log(.warning, "\(errorMessage ?? "Error nil")")
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    
    
}


// MARK: - Delegates

// MARK: UICollectionViewDataSource
extension SeriesViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if seasons.isEmpty {
            return 5
        } else {
            return seasons.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: SeasonCollectionViewCell.ID, for: indexPath) as! SeasonCollectionViewCell
        if indexPath == selectedSeasonIndexPath {
            cell.isSelected = true
            Logger.log(.success, "\(indexPath)")
        } else {
            cell.isSelected = false
        }
        if !seasons.isEmpty {
            cell.configureCell(seasonNumber: seasons[indexPath.row].number)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let label = UILabel(frame: CGRect.zero)
        if !seasons.isEmpty {
            label.text = "\(seasons[indexPath.row].number.ordinalString()) \("Seasons-Seasons".localized())"
        } else {
            label.text = "1 \("Seasons-Seasons".localized())"
        }
        label.font = .systemFont(ofSize: 12, weight: .semibold)
        label.sizeToFit()
        return CGSize(width: label.frame.width + (16 * 2), height: 34)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if selectedSeasonIndexPath != indexPath {
            selectedSeasonIndexPath = indexPath
        }
    }
    
    
}


extension SeriesViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if seasons.isEmpty {
            return 10
        } else {
            return seasons[selectedSeasonIndexPath.row].videos.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SeriesTableViewCell.ID,
                                                 for: indexPath) as! SeriesTableViewCell
        if !seasons.isEmpty {
            cell.configureCell(series: seasons[selectedSeasonIndexPath.row].videos[indexPath.row])
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.openMoviePlayerViewController(selectedSeries: indexPath.row)
    }
    
    
}
