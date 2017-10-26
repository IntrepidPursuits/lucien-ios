//
//  UIViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/4/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

extension UILabel {
    func addTextSpacing(spacing: Float) {
        if let labelText = text, labelText.characters.count > 0 {
            let attributedString = NSMutableAttributedString(
                string: labelText,
                attributes: [NSAttributedStringKey.kern : spacing]
            )
            attributedText = attributedString
        }
    }

    func setLineHeight(text: String, lineSpacing: Double) {
        let attributedString = NSMutableAttributedString(string: text)
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.lineSpacing = CGFloat(lineSpacing)
        attributedString.addAttribute(NSAttributedStringKey.paragraphStyle, value:paragraphStyle, range:NSRange(location: 0, length: attributedString.length))
        attributedText = attributedString
    }
}
