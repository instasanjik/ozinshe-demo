//
//  CarouselCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 27.02.2024.
//

import UIKit
import SnapKit

class CarouselCell: UICollectionViewCell {
    
    static let cellId = "CarouselCell"
    
    private lazy var imageView = UIImageView()
    
    lazy var welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.label
        label.text = NSLocalizedString("carouselWelcomeText", comment: "ÖZINŞE-ге қош келдің!")
        label.isUserInteractionEnabled = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = Style.Colors.gray400
        label.numberOfLines = 0
        label.textAlignment = .center
        return label
    }()
    
    private lazy var gradientView = GradientView()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    
}


private extension CarouselCell {
    
    func setupUI() {
        backgroundColor = .clear
        
        addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.top.right.equalToSuperview()
            make.height.equalTo(self.snp.width).multipliedBy(1.3)
        }
        
        addSubview(descriptionLabel)
        descriptionLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.left.right.equalToSuperview().inset(32)
            make.bottom.equalToSuperview().inset(220)
        }
        
        addSubview(gradientView)
        gradientView.snp.makeConstraints { make in
            make.left.right.equalToSuperview()
            make.top.equalTo(imageView.snp.centerY)
            make.bottom.equalTo(imageView.snp.bottom)
        }
        
        addSubview(welcomeLabel)
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(310)
        }
    }
    
    
}

// MARK: - Public

extension CarouselCell {
    
    public func configure(_ itemName: String) {
        imageView.image = UIImage(named: itemName)
        descriptionLabel.text = NSLocalizedString(itemName, comment: "Описание Cell карусели")
    }
    
    
}


class GradientView: UIView {

    // Default Colors
    var colors:[UIColor] = [.clear, Style.Colors.background]

    override func draw(_ rect: CGRect) {

        // Must be set when the rect is drawn
        setGradient(color1: colors[0], color2: colors[1])
    }

    func setGradient(color1: UIColor, color2: UIColor) {
        let context = UIGraphicsGetCurrentContext()
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [color1.cgColor, color2.cgColor] as CFArray, locations: [0, 1])!

        // Draw Path
        let path = UIBezierPath(rect: CGRectMake(0, 0, frame.width, frame.height))
        context!.saveGState()
        path.addClip()
        context!.drawLinearGradient(gradient, start: CGPointMake(frame.width / 2, 0), end: CGPointMake(frame.width / 2, frame.height), options: CGGradientDrawingOptions())
        context!.restoreGState()
    }

    override func layoutSubviews() {

        // Ensure view has a transparent background color (not required)
        backgroundColor = UIColor.clear
    }

}
