//
//  ComicReleaseDateCellViewModel.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 9/28/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation
import UIKit

struct ComicReleaseDateCellViewModel {
    /// Configures fonts, colors and border for a ComicReleaseDateCell
    func configure(cell: ComicReleaseDateFieldTableViewCell) {
        // Title Label Configuration
        cell.titleLabel.font = UIFont(name: LucienTheme.Fonts.Muli.light.rawValue, size: 12)
        cell.titleLabel.textColor = LucienTheme.coolGrey

        // UIButton Configuration
        cell.selectDateButton.setImage(UIImage(named: "dropDownArrow"), for: .normal)
        cell.selectDateButton.imageEdgeInsets.left = cell.selectDateButton.frame.width - 24
        cell.selectDateButton.tintColor = LucienTheme.dark
    }
}
