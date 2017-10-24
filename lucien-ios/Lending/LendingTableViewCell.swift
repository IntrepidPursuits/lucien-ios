//
//  LendingTableViewCell.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/20/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

class LendingTableViewCell: UITableViewCell {
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!

    override func prepareForReuse() {
        accessoryView = nil
    }
}
