//
//  OZPoorNetworkView.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 18.04.2024.
//

import UIKit
import SnapKit

protocol OZPoorNetworkViewDelegate: AnyObject {
    func poorNetworkTryAgainTapped()
}

final class OZPoorNetworkView: UIView {
    
    var delegate: OZPoorNetworkViewDelegate?
    
    private lazy var poorNetworkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "xmark.icloud.fill")
        imageView.tintColor = Style.Colors.white
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var poorNetworkTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = Style.Colors.label
        label.text = "PoorNetwork-Title".localized()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var poorNetworkBodyLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = Style.Colors.gray400
        label.text = "PoorNetwork-Body".localized()
        label.textAlignment = .center
        label.numberOfLines = 0
        return label
    }()
    
    private lazy var tryAgainButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Style.Colors.gray800
        button.tintColor = Style.Colors.purple400
        button.layer.cornerRadius = 8
        
        button.setTitle("PoorNetwork-TryAgain".localized(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        button.setTitleColor(Style.Colors.purple400, for: .normal)
        
        button.addTarget(self, action: #selector(tryAgainButtonTapped), for: .touchUpInside)
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


private extension OZPoorNetworkView {
    
    func setupUI() {
        self.backgroundColor = Style.Colors.background
        
        setupPoorNetworkImageView()
        setupPoorNetworkTitleLabel()
        setupPoorNetworkBodyLabel()
        setupTryAgainButton()
    }
    
    func setupPoorNetworkImageView() {
        self.addSubview(poorNetworkImageView)
        
        poorNetworkImageView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.height.equalTo(64)
        }
    }
    
    func setupPoorNetworkTitleLabel() {
        self.addSubview(poorNetworkTitleLabel)
        
        poorNetworkTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(poorNetworkImageView.snp.bottom).inset(-24)
            make.left.right.equalToSuperview().inset(48)
            make.centerX.equalToSuperview()
        }
    }
    
    func setupPoorNetworkBodyLabel() {
        self.addSubview(poorNetworkBodyLabel)
        
        poorNetworkBodyLabel.snp.makeConstraints { make in
            make.top.equalTo(poorNetworkTitleLabel.snp.bottom).inset(-12)
            make.left.right.equalToSuperview().inset(48)
            make.center.equalToSuperview()
        }
    }
    
    func setupTryAgainButton() {
        self.addSubview(tryAgainButton)
        
        tryAgainButton.snp.makeConstraints { make in
            make.top.equalTo(poorNetworkBodyLabel.snp.bottom).inset(-48)
            make.width.equalTo(148)
            make.height.equalTo(48)
            make.centerX.equalToSuperview()
        }
    }
    
    
}


private extension OZPoorNetworkView {
    
    @objc func tryAgainButtonTapped() {
        delegate?.poorNetworkTryAgainTapped()
    }
    
    
}
