//
//  SelectionLanguageView.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 28.03.2024.
//

import UIKit
import SnapKit

protocol LeaveConfirmationViewControllerDelegate: AnyObject {
    func leaveConfirmationViewWillDisappear()
}

class LeaveConfirmationViewController: UIViewController {
    
    // MARK: - Internal variables
    
    private var oldValueY: Double = 0
    private let SCROLL_VIEW_PADDING_Y: CGFloat = 86
    
    
    // MARK: - External variables
    
    public var delegate: LeaveConfirmationViewControllerDelegate?
    
    
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
    
    private lazy var leaveLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.label
        label.text = "Profile-Leave".localized()
        return label
    }()
    
    private lazy var leaveDescriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = Style.Colors.gray400
        label.text = "LeaveAccount-Confirmation".localized()
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var leaveButton: OZButton = {
        let button = OZButton()
        button.setTitle("LeaveAccount-Yes".localized(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.addTarget(self, action: #selector(leaveButtonTapped(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.setTitle("LeaveAccount-No".localized(), for: .normal)
        button.setTitleColor(Style.Colors.purple300, for: .normal)
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(cancelButtonTapped(_:)), for: .touchUpInside)
        return button
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
        delegate?.leaveConfirmationViewWillDisappear()
    }
    
    
}


// MARK: - UI Setups

private extension LeaveConfirmationViewController {
    
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
            make.top.equalToSuperview().inset(view.frame.height-270-ScreenSize.statusBarHeight+SCROLL_VIEW_PADDING_Y)
            make.bottom.equalToSuperview().inset(271+ScreenSize.statusBarHeight-SCROLL_VIEW_PADDING_Y-view.frame.height)
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
        
        setupLeaveLabel()
        setupLeaveDescriptionLabel()
        setupLeaveButton()
        setupCancelButton()
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
    
    func setupLeaveLabel() {
        contentView.addSubview(leaveLabel)
        
        leaveLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(58)
            make.left.equalToSuperview().inset(24)
        }
    }
    
    func setupLeaveDescriptionLabel() {
        contentView.addSubview(leaveDescriptionLabel)
        
        leaveDescriptionLabel.snp.makeConstraints { make in
            make.top.equalTo(leaveLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview().inset(24)
        }
    }
    
    func setupLeaveButton() {
        contentView.addSubview(leaveButton)
        
        leaveButton.snp.makeConstraints { make in
            make.top.equalTo(leaveDescriptionLabel.snp.bottom).inset(-32)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    
    func setupCancelButton() {
        contentView.addSubview(cancelButton)
        
        cancelButton.snp.makeConstraints { make in
            make.top.equalTo(leaveButton.snp.bottom).inset(-8)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    
    
}


// MARK: - Targets and handlers

extension LeaveConfirmationViewController {
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) { /// detect if tap is out of content view for dismissing scene
        guard var location = sender?.location(in: self.view) else { return }
        location.y = location.y + SCROLL_VIEW_PADDING_Y
        if !contentView.frame.contains(location) {
            self.dismiss(animated: true)
        }
    }
    
    @objc func leaveButtonTapped(_ sender: UIButton!) {
        Storage.sharedInstance.accessToken = ""
        UserDefaults.standard.set(nil, forKey: "accessToken")
        
        let vc = SignInNavigationViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.modalTransitionStyle = .flipHorizontal
        self.present(vc, animated: true)
    }
    
    @objc func cancelButtonTapped(_ sender: UIButton!) {
        self.dismiss(animated: true)
    }
    
    
}


// MARK: - Internal functions

private extension LeaveConfirmationViewController {
    
    func scrollToBottom() { /// automatic scroll scrollview to bottom for displaying content
        let bottomOffset = CGPoint(x: 0,
                                   y: scrollView.contentSize.height - scrollView.bounds.height + scrollView.adjustedContentInset.bottom + 12) /// 12 is a safe area zone for correct displaying content
        scrollView.setContentOffset(bottomOffset, animated: true)
    }
    
    
}


// MARK: - Delegates
// MARK: UIScrollViewDelegate
extension LeaveConfirmationViewController: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) { /// determine whether the user has moved the menu below the death zone for automatic closure
        if oldValueY > scrollView.contentOffset.y && scrollView.contentOffset.y < 43 {
            self.dismiss(animated: true)
        }
        oldValueY = scrollView.contentOffset.y
    }
    
    
}


