//
//  ScreenshotCollectionViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 15.03.2024.
//

import UIKit
import SnapKit

class ScreenshotCollectionViewCell: UICollectionViewCell {
    
    // MARK: - External variables
    
    static let ID: String = "ScreenshotCollectionViewCell"
    
    
    // MARK: - UI Elements
    
    private lazy var screenshotImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "previewImageView")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 8
        return imageView
    }()
    
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: - UI Setups

private extension ScreenshotCollectionViewCell {
    
    func setupUI() {
        setupScreenshotImageView()
    }
    
    func setupScreenshotImageView() {
        self.addSubview(screenshotImageView)
        
        screenshotImageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    
}


// MARK: - External functions

extension ScreenshotCollectionViewCell {
    
    public func configureCell(screenshot: Screenshot) {
        self.screenshotImageView.kf.setImage(with: screenshot.imageURL)
    }
    
    
}
