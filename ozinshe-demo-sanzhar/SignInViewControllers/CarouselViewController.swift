//
//  ViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 26.02.2024.
//

import UIKit
import SnapKit


class CarouselViewController: UIViewController {
    
    let welcomeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 24, weight: .bold)
        label.textColor = Style.Colors.label
        label.text = NSLocalizedString("carouselWelcomeText", comment: "ÖZINŞE-ге қош келдің!")
        label.isExclusiveTouch = false
        return label
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = Style.Colors.background
        
        addWelcomeLabel()
        
    }
    
    
}


extension CarouselViewController {
    
    private func addWelcomeLabel() {
        view.addSubview(welcomeLabel)
        
        welcomeLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().inset(310)
        }
    }
    
    
}
