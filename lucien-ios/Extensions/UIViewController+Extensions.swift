//
//  UIViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/4/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

extension UIViewController {

}

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
}
