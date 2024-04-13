//
//  GradientView.swift
//  ozinshe-demo-sanzhar
//
//  Created by Sanzhar Koshkarbayev on 08.04.2024.
//

import Foundation
import UIKit

class GradientView: UIView {
    
    // MARK: - Internal variables
    
    var colors: [UIColor] = [.clear, Style.Colors.background]
    
    
    // MARK: - Overriding internal functions
    
    override func draw(_ rect: CGRect) {
        setGradient(color1: colors[0], color2: colors[1])
    }
    
    override func layoutSubviews() {
        backgroundColor = UIColor.clear
    }
    
    
    // MARK: - Internal functions
    
    private func setGradient(color1: UIColor, color2: UIColor) {
        let context = UIGraphicsGetCurrentContext()
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: [color1.cgColor, color2.cgColor] as CFArray, locations: [0, 1])!
        
        let path = UIBezierPath(rect: CGRectMake(0, 0, frame.width, frame.height))
        context!.saveGState()
        path.addClip()
        context!.drawLinearGradient(gradient, start: CGPointMake(frame.width / 2, 0), end: CGPointMake(frame.width / 2, frame.height), options: CGGradientDrawingOptions())
        context!.restoreGState()
    }
    
    
}
