//
//  LucienTheme.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 9/27/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation
import UIKit

final class LucienTheme {
    // MARK: - Fonts

    enum Fonts {
        enum Muli: String {
            case black = "Muli-Black"
            case blackItalic = "Muli-BlackItalic"
            case bold = "Muli-Bold"
            case boldItalic = "Muli-BoldItalic"
            case extraBold = "Muli-ExtraBold"
            case extraBoldItalic = "Muli-ExtraBoldItalic"
            case extraLight = "Muli-ExtraLightItalic"
            case extraLightItalic = "Muli-ExtraLight"
            case italic = "Muli-Italic"
            case light = "Muli-Light"
            case lightItalic = "Muli-LightItalic"
            case regular = "Muli-Regular"
            case semiBold = "Muli-SemiBold"
            case semiBoldItalic = "Muli-SemiBoldItalic"
        }
        enum PermanentMarker: String {
            case regular = "PermanentMarker-Regular"
        }
    }

    // MARK: - Colors

    static let coolGrey = UIColor(redVal: 143, greenVal: 144, blueVal: 154, alphaVal: 1)
    static let dark = UIColor(redVal: 43, greenVal: 45, blueVal: 66, alphaVal: 1)
    static let silver = UIColor(redVal: 213, greenVal: 213, blueVal: 217, alphaVal: 1)
}

extension UIColor {
    /**
     Colors shown in Zeplin contain RGB values that are not in the range 0 to 1.
     In order for a color to appear it's RGB values must be between 0 and 1.
     The createUIColor achieves this by dividing each RGB value by 255.
     */
    convenience init(redVal: CGFloat, greenVal: CGFloat, blueVal: CGFloat, alphaVal: CGFloat) {
        self.init(red: CGFloat(redVal) / 255, green: CGFloat(greenVal) / 255, blue: CGFloat(blueVal) / 255, alpha: alphaVal)
    }
}

