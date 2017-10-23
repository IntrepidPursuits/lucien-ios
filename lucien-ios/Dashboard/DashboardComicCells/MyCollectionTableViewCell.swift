//
//  MyCollectionTableViewCell.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/23/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class MyCollectionTableViewCell: UITableViewCell {

    @IBOutlet private weak var comicTitleLabel: UILabel!
    @IBOutlet private weak var storyTitleLabel: UILabel!
    @IBOutlet weak var volumeIssueLabel: UILabel!

    static let reuseIdentifier = "myCollectionCell"

    func configure(comicTitle: String, storyTitle: String, volume: String, issueNumber: String) {
        comicTitleLabel.text = comicTitle
        storyTitleLabel.text = storyTitle
        volumeIssueLabel.text = "Volume " + volume + ", Issue #" + issueNumber
    }
}
