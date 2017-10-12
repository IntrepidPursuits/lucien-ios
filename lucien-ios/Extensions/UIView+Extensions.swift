//
//  UIView+Extensions.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/12/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    class func loadFromNibNamed(nibNamed: String, bundle: Bundle? = nil) -> UIView? {
        return UINib(
            nibName: nibNamed,
            bundle: bundle
            ).instantiate(withOwner: nil, options: nil)[0] as? UIView
    }
}
