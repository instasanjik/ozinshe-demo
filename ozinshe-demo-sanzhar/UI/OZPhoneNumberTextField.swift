//
//  PhoneNumberTextField.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 12.04.2024.
//

import UIKit

class OZPhoneNumberTextField: OZTextField {
    
    // MARK: - Properties
    
    private let maxLength = 18
    private var currentPhoneNumber = ""
    private var previousTextFieldContent: String?
    private var previousSelection: UITextRange?
    
    var isValid: Bool {
        return currentPhoneNumber.count == maxLength
    }
    
    
    // MARK: - Initialization
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    
    // MARK: - UITextField Delegate
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        guard text.count <= maxLength else {
            textField.text = previousTextFieldContent
            textField.selectedTextRange = previousSelection
            return
        }
        
        let filteredText = text.filter { $0.isNumber }
        // +7 (7XX) XXX-XX-XX
        // 123456789012345678
        // 77011231233
        // 01234567890
        var formattedText = ""
        for (index, char) in filteredText.enumerated() {
            let formatterSubstring: String
            switch index {
            case 0: formatterSubstring = "+\(char)"
            case 1: formatterSubstring = " (\(char)"
            case 3: formatterSubstring = "\(char)) "
            case 6, 8: formatterSubstring = "\(char)-"
            default: formatterSubstring = "\(char)"
            }
            formattedText += formatterSubstring
        }
        
        if let previousText = previousTextFieldContent, previousText.count > text.count {
            if let lastChar = text.last, lastChar == " " {
                formattedText.removeLast()
            }
        }
        
        textField.text = formattedText
        currentPhoneNumber = filteredText
        
        previousTextFieldContent = textField.text
        previousSelection = textField.selectedTextRange
    }
    
    override func deleteBackward() {
        super.deleteBackward()
        
        if let lastChar = text?.last, lastChar == " " || lastChar == ")" || lastChar == "(" || lastChar == "-" {
            text?.removeLast()
        }
        
        if let text = text {
            currentPhoneNumber = text.filter { $0.isNumber }
        }
    }
    
    
}
