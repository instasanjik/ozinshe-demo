//
//  SeriesTableViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 17.03.2024.
//

import UIKit
import SnapKit
import SkeletonView

class SeriesTableViewCell: UITableViewCell {
    
    // MARK: - External variables
    
    static let ID: String = "SeriesTableViewCell"
    
    
    // MARK: - UI Elements
    
    private lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "previewImageView")
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isSkeletonable = true
        return imageView
    }()
    
    private lazy var seriesLabel: UILabel = {
        let label = UILabel()
        label.text = "SPLASH_TEXT"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.StaticColors.label
        return label
    }()
    
    private lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Style.Colors.gray800
        return view
    }()
    
    
    // MARK: - View Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    
}


// MARK: - UI Elements

extension SeriesTableViewCell {
    
    func setupUI() {
        self.selectionStyle = .none
        self.backgroundColor = .clear
        
        setupPreviewImageView()
        setupSeriesLabel()
        setupSeparatorView()
    }
    
    func setupPreviewImageView() {
        self.addSubview(previewImageView)
        
        previewImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(178)
        }
    }
    
    func setupSeriesLabel() {
        self.addSubview(seriesLabel)
        
        seriesLabel.snp.makeConstraints { make in
            make.top.equalTo(previewImageView.snp.bottom).inset(-8)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(22)
        }
    }
    
    func setupSeparatorView() {
        self.addSubview(separatorView)
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(seriesLabel.snp.bottom).inset(-16)
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
    }
    
    
}


// MARK: - External variables

extension SeriesTableViewCell {
    
    func configureCell(series: Series) {
        self.previewImageView.kf.setImage(with: URL(string: series.previewLink))
        self.seriesLabel.text = "\(series.number.ordinalString()) \("Seasons-episode".localized())"
    }
    
    
}
