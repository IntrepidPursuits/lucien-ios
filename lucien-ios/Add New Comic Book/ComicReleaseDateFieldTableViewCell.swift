//
//  ComicReleaseDateTableViewCell.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 9/27/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

class ComicReleaseDateFieldTableViewCell: UITableViewCell {
	static let identifier = "releaseDateCell"
    @IBOutlet weak var releaseDatePicker: UIDatePicker!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var selectDateButton: UIButton!
}
