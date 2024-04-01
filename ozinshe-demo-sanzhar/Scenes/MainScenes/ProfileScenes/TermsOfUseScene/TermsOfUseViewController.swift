//
//  TermsOfUseViewController.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 29.03.2024.
//

import UIKit
import SnapKit

class TermsOfUseViewController: UIViewController {
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.textColor = Style.Colors.label
        textView.font = .systemFont(ofSize: 14, weight: .semibold)
        textView.text = StaticData.termOfUse
        textView.isEditable = false
        textView.isSelectable = false
        return textView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        setTabBarHidden(false)
    }
    
    
}


extension TermsOfUseViewController {
    
    fileprivate func setupUI() {
        navigationItem.title = NSLocalizedString("Profile-TermsOfUse", comment: "Ережелер мен шарттар")
        navigationItem.backButtonTitle = ""
        view.backgroundColor = Style.Colors.background
        
        setupTextView()
    }
    
    fileprivate func setupTextView() {
        view.addSubview(textView)
        
        textView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide).inset(24)
            make.left.right.bottom.equalToSuperview().inset(24)
        }
    }
    
    
}
