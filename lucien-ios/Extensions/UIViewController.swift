//
//  UIViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/4/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

extension UIViewController {

//    @objc func backButtonTapped() {
//        dismiss(animated: true, completion: nil)
//    }
}

extension UILabel {
    func addTextSpacing(amount: Float) {
        if let labelText = text, labelText.characters.count > 0 {
            let attributedString = NSMutableAttributedString(string: labelText)
            attributedString.addAttribute(NSAttributedStringKey.kern, value: amount, range: NSRange(location: 0, length: attributedString.length - 1))
            attributedText = attributedString
        }
    }
}
