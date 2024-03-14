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
        tableView.register(GalleryListTableViewCell.self,
                           forCellReuseIdentifier: GalleryListTableViewCell.ID)
        tableView.register(MovieCardTableViewCell.self,
                           forCellReuseIdentifier: MovieCardTableViewCell.ID)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.Colors.background
        
        setupTableView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        mainTableView.cellForRow(at: IndexPath(row: 0, section: 0))?.showAnimatedGradientSkeleton(animation: DEFAULT_ANIMATION)
    }
    
    
    
    
}

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

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeaderTableViewCell.ID,
                                                 for: indexPath)
            cell.selectionStyle = .none
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: KeepWatchingTableViewCell.ID,
                                                 for: indexPath)
            cell.selectionStyle = .none
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: GalleryListTableViewCell.ID,
                                                 for: indexPath)
            cell.selectionStyle = .none
            return cell
//        case 3:
//            let cell = tableView.dequeueReusableCell(withIdentifier: GalleryListTableViewCell.ID,
//                                                 for: indexPath)
//            cell.selectionStyle = .none
//            return cell
        case 4:
            let cell = tableView.dequeueReusableCell(withIdentifier: MovieCardTableViewCell.ID,
                                                     for: indexPath) as! MovieCardTableViewCell
            cell.selectionStyle = .none
            cell.content = StaticData.genres
            return cell
//        case 5:
//            let cell = tableView.dequeueReusableCell(withIdentifier: MovieCardTableViewCell.ID,
//                                                     for: indexPath) as! MovieCardTableViewCell
//            cell.selectionStyle = .none
//            cell.content = StaticData.ageCategories
//            return cell
        default:
            return UITableViewCell(frame: .zero)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return 328
        case 1: return 194
        case 2: return 259
//        case 3: return 259
        case 4: return 150
//        case 5: return 150
        default: return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 32
    }
    
    func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        return UIView()
    }
    
    
}

