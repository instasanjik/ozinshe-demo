//
//  ProfileHeaderView.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.03.2024.
//

import UIKit
import SnapKit

class ProfileHeaderView: UIView {
    
    lazy var avatarImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatarImage")
        imageView.layer.cornerRadius = 52
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    lazy var myProfileLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.label
        label.text = "Менің профилім"
        return label
    }()
    
    lazy var emailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = Style.Colors.gray400
        label.text = "ali@gmail.com"
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.backgroundColor = Style.Colors.gray800
        
        setupAvatarImageView()
        setupMyProfileLabel()
        setupEmailLabel()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProfileHeaderView {
    
    fileprivate func setupAvatarImageView() {
        self.addSubview(avatarImageView)
        
        avatarImageView.snp.makeConstraints { make in
            make.top.equalToSuperview().inset(32)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(104)
        }
    }
    
    fileprivate func setupMyProfileLabel() {
        self.addSubview(myProfileLabel)
        
        myProfileLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(avatarImageView.snp.bottom).inset(-32)
        }
    }
    
    fileprivate func setupEmailLabel() {
        self.addSubview(emailLabel)
        
        emailLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(myProfileLabel.snp.bottom).inset(-8)
        }
    }
    
    
}
