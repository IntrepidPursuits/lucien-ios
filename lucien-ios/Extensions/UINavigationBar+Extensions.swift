//
//  UINavigationBar.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/4/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation
import UIKit

extension UINavigationBar {

    func setNavBarBackground() {
        isTranslucent = true
        barStyle = .default
        barTintColor = LucienTheme.white
        setValue(true, forKey: "hidesShadow")
    }

    func setNavBarTitle() {
        tintColor = LucienTheme.dark
        titleTextAttributes = [NSAttributedStringKey.font: LucienTheme.Fonts.permanentMarkerRegular(size: 30) ?? UIFont()]
    }
}
