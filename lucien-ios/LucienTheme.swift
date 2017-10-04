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

        // Muli
        static func muliBlack(size: CGFloat) -> UIFont? { return UIFont(name: "Muli-Black", size: size) }
        static func muliBlackItalic(size: CGFloat) -> UIFont? { return UIFont(name: "Muli-BlackItalic", size: size) }
        static func muliBold(size: CGFloat) -> UIFont? { return UIFont(name: "Muli-Bold", size: size) }
        static func muliBoldItalic(size: CGFloat) -> UIFont? { return UIFont(name: "Muli-BoldItalic", size: size) }
        static func muliExtraBold(size: CGFloat) -> UIFont? { return UIFont(name: "Muli-ExtraBold", size: size) }
        static func muliExtraBoldItalic(size: CGFloat) -> UIFont? { return UIFont(name: "Muli-ExtraBoldItalic", size: size) }
        static func muliExtraLight(size: CGFloat) -> UIFont? { return UIFont(name: "Muli-ExtraLightItalic", size: size) }
        static func muliExtraLightItalic(size: CGFloat) -> UIFont? { return UIFont(name: "Muli-ExtraLight", size: size) }
        static func muliItalic(size: CGFloat) -> UIFont? { return UIFont(name: "Muli-Italic", size: size) }
        static func muliLight(size: CGFloat) -> UIFont? { return UIFont(name: "Muli-Light", size: size) }
        static func muliLightItalic(size: CGFloat) -> UIFont? { return UIFont(name: "Muli-LightItalic", size: size) }
        static func muliRegular(size: CGFloat) -> UIFont? { return UIFont(name: "Muli-Regular", size: size) }
        static func muliSemiBold(size: CGFloat) -> UIFont? { return UIFont(name: "Muli-SemiBold", size: size) }
        static func muliSemiBoldItalic(size: CGFloat) -> UIFont? { return UIFont(name:  "Muli-SemiBoldItalic", size: size) }

        // PermanentMarker
        static func permanentMarkerRegular(size: CGFloat) -> UIFont? { return UIFont(name:  "PermanentMarker-Regular", size: size) }
    }

    // MARK: - Colors

    static let coolGrey = UIColor(redVal: 143, greenVal: 144, blueVal: 154, alphaVal: 1)
    static let dark = UIColor(redVal: 43, greenVal: 45, blueVal: 66, alphaVal: 1)
    static let silver = UIColor(redVal: 213, greenVal: 213, blueVal: 217, alphaVal: 1)
    static let white = UIColor(redVal: 255, greenVal: 255, blueVal: 255, alphaVal: 0.85)
    static let finishButtonGrey = UIColor(redVal: 55, greenVal: 58, blueVal: 78, alphaVal: 0.2)
    static let textFieldBottomBorderWarning = UIColor(redVal: 255, greenVal: 59, blueVal: 83, alphaVal: 1)
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
