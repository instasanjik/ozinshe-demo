//
//  ProfileSectionTableViewCell.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 26.03.2024.
//

import UIKit
import SnapKit

class ProfileSectionTableViewCell: UITableViewCell {
    
    // MARK: - External variables
    
    static let ID: String = "ProfileSectionTableViewCell"
    
    
    // MARK: - Internal variables
    
    private var type: CellType = .labelAndChevron
    private var cellData: (String, CellType)? = nil {
        didSet {
            guard let cellData = cellData else { return }
            nameLabel.text = cellData.0
            switch cellData.1 {
            case .labelAndChevron:
                setupUI(cellType: cellData.1, optionValue: NSLocalizedString("General-Edit", comment: "Өңдеу"))
            case .chevronOnly:
                setupUI(cellType: cellData.1)
            case .switchOnly:
                setupUI(cellType: cellData.1, isOn: true)
            }
        }
    }
    
    
    // MARK: - UI Elements
    
    private lazy var nameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        label.textColor = Style.Colors.gray200
        label.text = NSLocalizedString("Profile-PersonalData", comment: "Жеке деректер")
        return label
    }()
    
    private lazy var optionNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .semibold)
        label.textColor = Style.Colors.gray400
        label.text = NSLocalizedString("General-Edit", comment: "Өңдеу")
        return label
    }()
    
    private lazy var chevronImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var switchControl: UISwitch = {
        let switchControl = UISwitch()
        switchControl.onTintColor = Style.Colors.purple300
        switchControl.isOn = true
        return switchControl
    }()
    
    
    // MARK: - Overriding internal functions
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    
    // MARK: - View Life Cycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.backgroundColor = .clear
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}


// MARK: UI Setups

private extension ProfileSectionTableViewCell {
    
    func setupUI(cellType type: CellType,
                 optionValue: String = "",
                 isOn: Bool = true) {
        self.type = type
        self.selectionStyle = .none
        
        setupNameLabel()
        
        switch type {
        case .labelAndChevron:
            setupChevron()
            setupOptionNameLabel()
            optionNameLabel.text = optionValue
        case .chevronOnly:
            setupChevron()
        case .switchOnly:
            setupSwitch()
            switchControl.isOn = isOn
        }
    }
    
    func setupNameLabel() {
        self.contentView.addSubview(nameLabel)
        
        nameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.left.equalToSuperview().inset(24)
        }
    }
    
    func setupChevron() {
        self.contentView.addSubview(chevronImageView)
        
        chevronImageView.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(24)
            make.height.width.equalTo(16)
        }
    }
    
    func setupOptionNameLabel() {
        self.contentView.addSubview(optionNameLabel)
        
        optionNameLabel.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalTo(chevronImageView.snp.left).inset(-8)
        }
    }
    
    func setupSwitch() {
        self.contentView.addSubview(switchControl)
        
        switchControl.snp.makeConstraints { make in
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().inset(24)
        }
    }
    
    
}


extension ProfileSectionTableViewCell {
    
    func setupCellData(cellData: (String, CellType)?) {
        self.cellData = cellData
    }
    
    func setupCellOptionText() {
        self.optionNameLabel.text = StaticData.getLanguageName()
    }
    
    
}
