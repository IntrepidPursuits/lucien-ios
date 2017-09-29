//
//  ExpandableCell.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 9/29/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

protocol Expandable {
    /// Boolean that indicates whether a component (ex: UIButton, UIDatepicker, etc..) within a cell is hidden
    var expandableComponentIsHidden: Bool {get set}

    func expandCellAt(indexPath: IndexPath)
}
