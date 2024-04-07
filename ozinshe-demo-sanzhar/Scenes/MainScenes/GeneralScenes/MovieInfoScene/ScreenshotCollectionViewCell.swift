//
//  ScreenshotCollectionViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 15.03.2024.
//

import UIKit
import SnapKit

class ScreenshotCollectionViewCell: UICollectionViewCell {
    
    static let ID: String = "ScreenshotCollectionViewCell"
    
    lazy var screenshotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "previewImageView")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupScreenshotImageView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


extension ScreenshotCollectionViewCell {
    
    fileprivate func setupScreenshotImageView() {
        self.addSubview(screenshotImageView)
        
        screenshotImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}

extension ScreenshotCollectionViewCell {
    
    public func configureCell(screenshot: Screenshot) {
        self.screenshotImageView.kf.setImage(with: screenshot.imageURL)
    }
    
    
}
