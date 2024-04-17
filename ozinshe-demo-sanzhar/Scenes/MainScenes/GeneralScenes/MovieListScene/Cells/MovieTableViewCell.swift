//
//  MovieTableViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 20.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

class MovieTableViewCell: UITableViewCell {
    
    // MARK: - External variables
    
    static let ID: String = "MovieTableViewCell"
    
    
    // MARK: - UI Elements
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "previewImageView")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    private lazy var movieNameLabel: UILabel = {
        let label = UILabel()
        label.text = "SPLASH_TEXT"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.label
        return label
    }()
    
    private lazy var shortInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "SPLASH_TEXT"
        label.font = .systemFont(ofSize: 12, weight: .regular)
        label.textColor = Style.Colors.gray400
        return label
    }()
    
    private lazy var watchButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = Style.Colors.gray800
        button.tintColor = Style.Colors.purple400
        button.layer.cornerRadius = 8
        
        button.setTitle("Movie-Watch".localized(), for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 12, weight: .bold)
        button.setTitleColor(Style.Colors.purple400, for: .normal)
        
        button.setImage(UIImage(systemName: "play.fill"), for: .normal)
        button.imageView?.contentMode = .scaleAspectFit
        
        let padding: CGFloat = 8
        button.imageEdgeInsets = UIEdgeInsets(top: padding, left: -padding/2, bottom: padding, right: padding/2)
        
        return button
    }()
    
    
    // MARK: - Overriding internal functions
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        backgroundColor = selected ? Style.Colors.gray800 : .clear
    }
    
    override func setHighlighted(_ highlighted: Bool, animated: Bool) {
        backgroundColor = highlighted ? Style.Colors.gray800 : .clear
    }
    
    
    // MARK: - View Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    

}


// MARK: - UI Setups

private extension MovieTableViewCell {
    
    func setupUI() {
        self.backgroundColor = .clear
        
        setupPreviewImageView()
        setupMovieNameLabel()
        setupShortInfoLabel()
        setupWatchButton()
    }
    
    func setupPreviewImageView() {
        self.addSubview(previewImageView)
        
        previewImageView.snp.makeConstraints { make in
            make.top.left.bottom.equalToSuperview().inset(24)
            make.height.equalTo(104)
            make.width.equalTo(71)
        }
    }
    
    func setupMovieNameLabel() {
        self.addSubview(movieNameLabel)
        
        movieNameLabel.snp.makeConstraints { make in
            make.top.equalTo(previewImageView)
            make.left.equalTo(previewImageView.snp.right).inset(-16)
        }
    }
    
    func setupShortInfoLabel() {
        self.addSubview(shortInfoLabel)
        
        shortInfoLabel.snp.makeConstraints { make in
            make.top.equalTo(movieNameLabel.snp.bottom).inset(-8)
            make.left.equalTo(movieNameLabel)
            make.right.equalToSuperview().inset(24) 
        }
    }
    
    func setupWatchButton() {
        self.addSubview(watchButton)
        
        watchButton.snp.makeConstraints { make in
            make.top.equalTo(shortInfoLabel.snp.bottom).inset(-24)
            make.left.equalTo(movieNameLabel)
            make.width.greaterThanOrEqualTo(80)
            make.height.equalTo(26)
        }
    }
    
    
}


// MARK: - External functions

extension MovieTableViewCell {
    
    func configureCell(content movie: MovieWithDetails) {
        self.movieNameLabel.text = movie.name
        self.previewImageView.kf.setImage(with: URL(string: movie.poster_link))
        self.shortInfoLabel.text = movie.shortInfo
    }
    
    func localizeCell() {
        self.watchButton.setTitle("Movie-Watch".localized(), for: .normal)
    }
    
    
}
