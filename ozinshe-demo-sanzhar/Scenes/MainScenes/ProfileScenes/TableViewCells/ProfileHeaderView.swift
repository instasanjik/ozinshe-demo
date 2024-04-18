//
//  ProfileHeaderView.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.03.2024.
//

import UIKit
import SnapKit

class ProfileHeaderView: UITableViewHeaderFooterView  {
    
    // MARK: - UI Elements
    
    private lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatarImage")
        imageView.layer.cornerRadius = 52
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private lazy var myProfileLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.label
        label.text = "Profile-MyProfile".localized()
        return label
    }()
    
    private lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = Style.Colors.gray400
        label.text = "ali@gmail.com"
        return label
    }()
    
    
    // MARK: - View Life Cycle
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: - UI Setups

private extension ProfileHeaderView {
    
    func setupUI() {
        self.backgroundColor = Style.Colors.gray800
        self.contentView.backgroundColor = Style.Colors.gray800
        
        setupAvatarImageView()
        setupMyProfileLabel()
        setupEmailLabel()
    }
    
    func setupAvatarImageView() {
        self.addSubview(avatarImageView)
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(104)
        }
    }
    
    func setupMyProfileLabel() {
        self.addSubview(myProfileLabel)
        
        myProfileLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(avatarImageView.snp.bottom).inset(-32)
        }
    }
    
    func setupEmailLabel() {
        self.addSubview(emailLabel)
        
        emailLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(myProfileLabel.snp.bottom).inset(-8)
        }
    }
    
    
}


// MARK: External functions

extension ProfileHeaderView {
    
    func updateEmail(with email: String?) {
        emailLabel.text = email ?? ""
    }
    
    func localizeData() {
        self.myProfileLabel.text = "Profile-MyProfile".localized()
    }
    
    
}
