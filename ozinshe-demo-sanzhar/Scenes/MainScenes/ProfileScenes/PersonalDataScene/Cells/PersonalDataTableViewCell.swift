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
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .medium)
        label.textColor = Style.Colors.label
        return label
    }()
    
    lazy var valueTextField: OZTextField = {
        let textField = OZTextField()
        textField.placeholder = optionNameLabel.text
        textField.padding = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        return textField
    }()
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
}

private extension PersonalDataTableViewCell {
    
    func setupUI() {
        self.backgroundColor = .clear
        self.selectionStyle = .none
    }
    
    func setupOptionNameLabel() {
        self.addSubview(optionNameLabel)
        
        optionNameLabel.snp.makeConstraints { make in
            make.top.left.right.equalToSuperview().inset(24)
        }
    }
    
    func setupValueLabel() {
        self.addSubview(valueLabel)
        
        valueLabel.snp.makeConstraints { make in
            make.top.equalTo(optionNameLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview().inset(24)
        }
    }
    
    func setupValueTextField() {
        self.addSubview(valueTextField)
        
        valueTextField.snp.makeConstraints { make in
            make.top.equalTo(optionNameLabel.snp.bottom).inset(-8)
            make.left.right.equalToSuperview().inset(24)
            make.height.equalTo(56)
        }
    }
    
    
}


extension PersonalDataTableViewCell {
    
    func setupCell(sectionName: String, isDataEditing: Bool) {
        setupOptionNameLabel()
        updateCellState(to: isDataEditing)
    }
    
    private func updateCellState(to isEditing: Bool) {
        if isEditing {
            valueTextField.text = valueLabel.text
            valueLabel.removeFromSuperview()
            setupValueTextField()
        } else {
            valueLabel.text = valueTextField.text
            valueTextField.removeFromSuperview()
            setupValueLabel()
        }
    }
    
    
}
