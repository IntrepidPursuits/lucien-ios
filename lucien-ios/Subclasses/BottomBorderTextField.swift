//
//  BottomBorderTextField.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/12/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

final class BottomBorderTextField: UITextField {
    private let bottomBorder = CALayer()

    var borderColor: UIColor? {
        get {
            if let color = bottomBorder.backgroundColor {
                return UIColor(cgColor: color)
            } else {
                return nil
            }
        }
        set {
            bottomBorder.backgroundColor = newValue?.cgColor
        }
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        createBottomBorder()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        createBottomBorder()
    }

    private func createBottomBorder() {
        bottomBorder.frame = CGRect(x: 0.0, y: frame.height - 3.0, width: frame.width - LucienConstants.textFieldBorderOffset, height: 1.0)
        bottomBorder.backgroundColor = LucienTheme.silver.cgColor
        borderStyle = UITextBorderStyle.none
        layer.addSublayer(bottomBorder)
    }
}
