//
//  SelectionLanguageTableViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 28.03.2024.
//

import UIKit
import SnapKit

class SelectionLanguageTableViewCell: UITableViewCell {
    
    // MARK: - External variables
    
    static let ID: String = "SelectionLanguageTableViewCell"
    
    
    // MARK: - UI Elements
    
    private lazy var languageNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = Style.Colors.label
        return label
    }()
    
    private lazy var checkImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "checkmark.circle.fill")
        imageView.tintColor = Style.Colors.purple300
        return imageView
    }()
    
    
    // MARK: - Overriding internal functions
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {}
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        if selected {
            setupCheckImageView()
        } else {
            checkImageView.removeFromSuperview()
        }
    }
    
    
    // MARK: - View Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: - UI Setups

private extension SelectionLanguageTableViewCell {
    
    func setupUI() {
        self.backgroundColor = .clear
        setupLanguageNameLabel()
    }
    
    func setupLanguageNameLabel() {
        addSubview(languageNameLabel)
        
        languageNameLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().inset(24)
            make.centerY.equalToSuperview()
        }
    }
    
    func setupCheckImageView() {
        addSubview(checkImageView)
        
        checkImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(24)
            make.width.height.equalTo(24)
        }
    }
    
    
}
