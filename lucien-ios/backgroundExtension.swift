//
//  backgroundExtension.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 9/27/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func addBackground() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height

        let homeScreenBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        homeScreenBackground.image = UIImage(named: "homeScreenImage")
        homeScreenBackground.contentMode = UIViewContentMode.scaleAspectFill

        self.addSubview(homeScreenBackground)
        self.sendSubview(toBack: homeScreenBackground)
    }}
