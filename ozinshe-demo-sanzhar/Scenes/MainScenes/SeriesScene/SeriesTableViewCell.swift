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
    
    static let ID: String = "SeriesTableViewCell"
    
    
    lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "previewImageView")
        imageView.layer.cornerRadius = 12
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        imageView.isSkeletonable = true
        return imageView
    }()
    
    lazy var seriesLabel: UILabel = {
        let label = UILabel()
        label.text = "1 -ші бөлім"
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.StaticColors.label
        return label
    }()
    
    lazy var separatorView: UIView = {
        let view = UIView()
        view.backgroundColor = Style.Colors.gray800
        return view
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = .clear
        
        setupPreviewImageView()
        setupSeriesLabel()
        setupSeparatorView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
}

extension SeriesTableViewCell {
    
    fileprivate func setupPreviewImageView() {
        self.addSubview(previewImageView)
        
        previewImageView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(178)
        }
    }
    
    fileprivate func setupSeriesLabel() {
        self.addSubview(seriesLabel)
        
        seriesLabel.snp.makeConstraints { make in
            make.top.equalTo(previewImageView.snp.bottom).inset(-8)
            make.left.equalToSuperview().inset(24)
            make.height.equalTo(22)
        }
    }
    
    fileprivate func setupSeparatorView() {
        self.addSubview(separatorView)
        
        separatorView.snp.makeConstraints { make in
            make.top.equalTo(seriesLabel.snp.bottom).inset(-16)
            make.left.right.equalToSuperview().inset(24)
            make.bottom.equalToSuperview().inset(16)
            make.height.equalTo(1)
        }
    }
    
    
}
