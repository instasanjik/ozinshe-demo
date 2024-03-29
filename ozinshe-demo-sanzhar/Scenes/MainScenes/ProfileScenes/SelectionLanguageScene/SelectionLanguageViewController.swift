//
//  SelectionLanguageView.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 28.03.2024.
//

import UIKit
import SnapKit

protocol SelectionLanguageViewControllerDelegate: AnyObject {
    func viewWillDisappear()
}

class SelectionLanguageViewController: UIViewController {
    
    var delegate: SelectionLanguageViewControllerDelegate?
    var oldValueY: Double = 0
    let SCROLL_VIEW_PADDING_Y: CGFloat = 124
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        
        scrollView.addSubview(scrollViewContentView)
        scrollViewContentView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalTo(scrollView.contentLayoutGuide)
            make.height.equalTo(scrollView.frameLayoutGuide).priority(250)
            make.width.equalToSuperview()
        }
        
        scrollView.delegate = self
        scrollView.showsVerticalScrollIndicator = false
        
        return scrollView
    }()
    
    lazy var invisibleView: UIView = {
        let view = UIView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    lazy var scrollViewContentView = OZExpandedView()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = Style.Colors.gray800
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    lazy var browView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2.5
        view.clipsToBounds = true
        view.backgroundColor = Style.Colors.gray500
        return view
    }()
    
    lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.label
        
        label.text = "Тіл"
        
        return label
    }()

    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SelectionLanguageTableViewCell.self, forCellReuseIdentifier: SelectionLanguageTableViewCell.ID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        return tableView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupScrollView()
        setupContentView()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        let bottomOffset = CGPoint(x: 0, y: scrollView.contentSize.height - scrollView.bounds.height + scrollView.adjustedContentInset.bottom + 12)
        scrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.viewWillDisappear()
    }
    
    
}

extension SelectionLanguageViewController {
    
    fileprivate func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    fileprivate func setupContentView() {
        scrollViewContentView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(view.frame.height-303-ScreenSize.statusBarHeight+SCROLL_VIEW_PADDING_Y)
            make.bottom.equalToSuperview().inset(304+ScreenSize.statusBarHeight-SCROLL_VIEW_PADDING_Y-view.frame.height)
            make.left.right.equalToSuperview()
            make.height.equalTo(view.frame.height)
        }
        
        
        
        scrollViewContentView.addSubview(invisibleView)
        invisibleView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(contentView.snp.top)
        }
        
        setupBrowView()
        setupLanguageLabel()
        setupTableView()
    }
    
    fileprivate func setupBrowView() {
        contentView.addSubview(browView)
        
        browView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(21)
            make.centerX.equalToSuperview()
            make.height.equalTo(5)
            make.width.equalTo(64)
        }
    }
    
    fileprivate func setupLanguageLabel() {
        contentView.addSubview(languageLabel)
        
        languageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(58)
            make.left.equalToSuperview().inset(24)
        }
    }
    
    fileprivate func setupTableView() {
        contentView.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(languageLabel.snp.bottom).inset(-12)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(367)
        }
    }
    
    
}


extension SelectionLanguageViewController {
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        guard var location = sender?.location(in: self.view) else { return }
        location.y = location.y + SCROLL_VIEW_PADDING_Y
        if !contentView.frame.contains(location) {
            self.dismiss(animated: true)
        }
    }
    
    
}



extension SelectionLanguageViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectionLanguageTableViewCell.ID, for: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    
}

extension SelectionLanguageViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if oldValueY > scrollView.contentOffset.y && scrollView.contentOffset.y < 43 {
            self.dismiss(animated: true)
        }
        oldValueY = scrollView.contentOffset.y
    }
    
    
}


