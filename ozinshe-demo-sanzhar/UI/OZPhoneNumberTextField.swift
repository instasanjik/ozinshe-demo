//
//  PhoneNumberTextField.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 12.04.2024.
//

import UIKit

final class OZPhoneNumberTextField: OZTextField {
    
    // MARK: - Internal variables
    
    private let maxLength = 18
    private var currentPhoneNumber = ""
    private var previousTextFieldContent: String?
    private var previousSelection: UITextRange?
    
    
    // MARK: - External variables
    
    var isValid: Bool {
        return currentPhoneNumber.count == maxLength
    }
    
    
    // MARK: - Overriding internal functions
    
    override func deleteBackward() {
        super.deleteBackward()
        
        if let lastChar = text?.last, lastChar == " " || lastChar == ")" || lastChar == "(" || lastChar == "-" {
            text?.removeLast()
        }
        
        if let text = text {
            currentPhoneNumber = text.filter { $0.isNumber }
        }
    }
    
    
    // MARK: - View Life Cycle
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    
}


// MARK: - Targets and handlers

extension OZPhoneNumberTextField {
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        guard let text = textField.text else { return }
        
        guard text.count <= maxLength else {
            textField.text = previousTextFieldContent
            textField.selectedTextRange = previousSelection
            return
        }
        
        let filteredText = text.filter { $0.isNumber }
        
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
    
    
}


// MARK: - Internal functions

private extension OZPhoneNumberTextField {
    
    func commonInit() {
        addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
    }
    
    
}
