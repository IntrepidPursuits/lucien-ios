//
//  AddCoverCellViewModel.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 9/27/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//
import Foundation
import UIKit
import QuartzCore

struct AddCoverCellViewModel {
    /// Configures fonts and colors for a AddCoverTableViewCell. 
    func configure(cell: AddCoverTableViewCell){
        cell.titleLabel.font = UIFont(name: LucienTheme.Fonts.Muli.light.rawValue, size: 12)
        cell.titleLabel.textColor = LucienTheme.coolGrey

        // titleLabel Configuration 
        cell.addCoverButton.titleLabel?.lineBreakMode = .byWordWrapping
        cell.addCoverButton.titleLabel?.textAlignment = .center
        cell.addCoverButton.setTitle("Take \n Cover \n Photo", for: .normal)
        cell.addCoverButton.titleLabel?.font = UIFont(name: LucienTheme.Fonts.Muli.bold.rawValue, size: 13)
        cell.addCoverButton.setTitleColor(LucienTheme.dark, for: .normal)
        cell.addCoverButton.titleEdgeInsets.top = 25
    }
}
