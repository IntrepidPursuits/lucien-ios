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

    static func setNavBarBackground(navigationController: UINavigationController) {
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.barTintColor = LucienTheme.white
        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")
    }

    static func setNavBarTitle(navigationController: UINavigationController, title: String) {
        navigationController.navigationItem.title = title
        navigationController.navigationBar.tintColor = LucienTheme.dark
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: LucienTheme.Fonts.permanentMarkerRegular(size: 30) ?? UIFont()]
    }
}
