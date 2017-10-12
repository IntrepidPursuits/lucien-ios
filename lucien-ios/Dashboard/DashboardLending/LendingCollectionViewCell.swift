//
//  LendingCollectionViewCell.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/10/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class LendingCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var titleLabel: UILabel!

    static let lendingReuseIdentifier = "lendingComicCell"

    func configure(comicTitle: String) {
        titleLabel.text = comicTitle
    }
}
