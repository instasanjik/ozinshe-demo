//
//  MovieInfoViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 14.03.2024.
//

import UIKit
import SnapKit

class MovieInfoViewController: UIViewController {
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        return scrollView
    }()
    
    lazy var contentView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = -32
        return stackView
    }()
    
    lazy var containerView = UIView()
    
    lazy var previewImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "previewImageView")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    lazy var infoView: UIView = {
        let view = UIView()
        view.backgroundColor = Style.Colors.background
        view.clipsToBounds = true
        view.layer.cornerRadius = 32
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    lazy var shadowGradientView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "gradient")
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = Style.Colors.background
        
        setupScrollView()
        setupPreviewImageView()
        setupInfoView()
    }
    
    
}


extension MovieInfoViewController {
    
    fileprivate func setupScrollView() {
        view.addSubview(scrollView)
        
        scrollView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        scrollView.addSubview(contentView)
        
        contentView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
            make.width.equalToSuperview()
        }
    }
    
    fileprivate func setupPreviewImageView() {
        contentView.addArrangedSubview(containerView)
        containerView.backgroundColor = .red
        
        containerView.snp.makeConstraints { make in
            make.height.equalTo(340)
        }
        
        
        containerView.addSubview(previewImageView)
        
        previewImageView.snp.makeConstraints { make in
            make.top.equalTo(view)
            make.left.right.bottom.equalToSuperview()
        }
        
        
        previewImageView.addSubview(shadowGradientView)
        
        shadowGradientView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    fileprivate func setupInfoView() {
        contentView.addArrangedSubview(infoView)
        
        infoView.snp.makeConstraints { make in
            make.height.equalTo(900)
        }
    }
    
    
}
