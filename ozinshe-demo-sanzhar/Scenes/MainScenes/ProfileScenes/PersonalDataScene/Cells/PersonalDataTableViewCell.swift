//
//  PersonalDataTableViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 28.03.2024.
//

import UIKit
import SnapKit

class PersonalDataTableViewCell: UITableViewCell {
    
    static let ID: String = "PersonalDataTableViewCell"
    
    
    lazy var optionNameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = Style.Colors.gray400
        
        label.text = "Сіздің атыңыз"
        
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = Style.Colors.label
        
        label.text = "Айдар"
        
        return label
    }()
    
    lazy var valueTextField: OZTextField = {
        let textField = OZTextField()
        
        textField.placeholder = "Поиск"
        textField.padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        return textField
    }()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    public func setupUI(isDataEditing: Bool) {
        setupOptionNameLabel()
        if isDataEditing {
            setupValueTextField()
        } else {
            setupValueLabel()
        }
    }

}

extension PersonalDataTableViewCell {
    
    fileprivate func setupOptionNameLabel() {
        addSubview(optionNameLabel)
        
        optionNameLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(24)
        }
    }
    
    fileprivate func setupValueLabel() {
        addSubview(valueLabel)
        
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(optionNameLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview().inset(24)
        }
    }
    
    fileprivate func setupValueTextField() {
        addSubview(valueTextField)
        
        valueTextField.snp.makeConstraints { make in
            make.top.equalTo(optionNameLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    
    
}
