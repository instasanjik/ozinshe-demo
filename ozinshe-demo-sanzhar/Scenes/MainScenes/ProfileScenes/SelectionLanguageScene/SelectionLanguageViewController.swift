//
//  SelectionLanguageView.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 28.03.2024.
//

import UIKit
import SnapKit

// MARK: - SelectionLanguageViewControllerDelegate
protocol SelectionLanguageViewControllerDelegate: AnyObject {
    func selectionLanguageViewWillDisappear()
}

class SelectionLanguageViewController: UIViewController {
    
    // MARK: - Internal variables
    private var oldValueY: Double = 0
    private var lastSelectedRow: IndexPath?
    private let SCROLL_VIEW_PADDING_Y: CGFloat = 86
    
    
    // MARK: - External variables
    
    var delegate: SelectionLanguageViewControllerDelegate?
    
    
    // MARK: - UI Elements
    
    private lazy var scrollView: UIScrollView = {
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
    
    private lazy var invisibleView: UIView = {
        let view = UIView()
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        view.addGestureRecognizer(tap)
        
        return view
    }()
    
    private lazy var scrollViewContentView = OZExpandedView()
    
    private lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = Style.Colors.gray800
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private lazy var browView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 2.5
        view.clipsToBounds = true
        view.backgroundColor = Style.Colors.gray500
        return view
    }()
    
    private lazy var languageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.label
        label.text = "Profile-Language".localized()
        return label
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(SelectionLanguageTableViewCell.self, forCellReuseIdentifier: SelectionLanguageTableViewCell.ID)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.backgroundColor = .clear
        tableView.separatorColor = Style.Colors.gray700
        return tableView
    }()
    
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        scrollToBottom()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        delegate?.selectionLanguageViewWillDisappear()
    }
    
    
}


// MARK: - UI Setups

private extension SelectionLanguageViewController {
    
    func setupUI() {
        setupScrollView()
        setupContentView()
    }
    
    func setupScrollView() {
        self.view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
    }
    
    func setupContentView() {
        
        scrollViewContentView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(view.frame.height-303-ScreenSize.statusBarHeight+SCROLL_VIEW_PADDING_Y)
            make.bottom.equalToSuperview().inset(304+ScreenSize.statusBarHeight-SCROLL_VIEW_PADDING_Y-view.frame.height)
            make.left.right.equalToSuperview()
            make.height.equalTo(view.frame.height)
        }
        /// 303 is a original height of content view in design
        /// top = view.height - content view height - statusbat height + 124 (scroll view padding Y)
        /// scroll view padding Y - is a safe area for displaying a content view correctly and make it scrollable on Y axis of scroll view
        
        scrollViewContentView.addSubview(invisibleView)
        invisibleView.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview()
            make.bottom.equalTo(contentView.snp.top)
        }
        
        setupBrowView()
        setupLanguageLabel()
        setupTableView()
    }
    
    func setupBrowView() {
        contentView.addSubview(browView)
        
        browView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(21)
            make.centerX.equalToSuperview()
            make.height.equalTo(5)
            make.width.equalTo(64)
        }
    }
    
    func setupLanguageLabel() {
        contentView.addSubview(languageLabel)
        
        languageLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(58)
            make.left.equalToSuperview().inset(24)
        }
    }
    
    func setupTableView() {
        contentView.addSubview(tableView)
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(languageLabel.snp.bottom).inset(-12)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(367)
        }
    }
    
    
}


// MARK: - Targets and handlers

private extension SelectionLanguageViewController {
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) { /// detect if tap is out of content view for dismissing scene
        guard var location = sender?.location(in: self.view) else { return }
        location.y = location.y + SCROLL_VIEW_PADDING_Y
        if !contentView.frame.contains(location) {
            self.dismiss(animated: true)
        }
    }
    
    
}


// MARK: - Delegates
// MARK: UITableViewDelegate
extension SelectionLanguageViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let code = LanguageManager.languages[indexPath.row].systemCode
        
        
        if LanguageManager.currentLanguageSystemCode == code {
            cell.setSelected(true, animated: true)
            lastSelectedRow = indexPath
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 64
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        LanguageManager.changeLanguage(to: LanguageManager.languages[indexPath.row])
    }
    
    
}


// MARK: UITableViewDataSource
extension SelectionLanguageViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SelectionLanguageTableViewCell.ID, for: indexPath) as! SelectionLanguageTableViewCell
        cell.configureCell(withLanguageName: LanguageManager.languages[indexPath.row].displayName)
        return cell
    }
    
    
}


// MARK: UIScrollViewDelegate
extension SelectionLanguageViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if oldValueY > scrollView.contentOffset.y && scrollView.contentOffset.y < 43 {
            self.dismiss(animated: true)
        }
        oldValueY = scrollView.contentOffset.y
    }
    
    fileprivate func scrollToBottom() {
        let bottomOffset = CGPoint(x: 0,
                                   y: scrollView.contentSize.height - scrollView.bounds.height + scrollView.adjustedContentInset.bottom + 12) /// 12 is a safe area zone for correct displaying content
        scrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    
}


