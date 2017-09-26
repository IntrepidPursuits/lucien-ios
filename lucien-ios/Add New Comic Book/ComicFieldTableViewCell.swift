//
//  ComicInfoFieldTableViewCell.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 9/26/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class ComicTextFieldTableViewCell: UITableViewCell {
    static let identifier = "textFieldCell"
    @IBOutlet weak var comicInfoTextField: UITextField!
    @IBOutlet weak var cellContentView: UIView!
    @IBOutlet weak var titleLabel: UILabel!
}
