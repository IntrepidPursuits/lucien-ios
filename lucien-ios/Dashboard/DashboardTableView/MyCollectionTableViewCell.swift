//
//  MyCollectionTableViewCell.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/23/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class MyCollectionTableViewCell: UITableViewCell {

    @IBOutlet private weak var comicImageView: UIImageView!
    @IBOutlet private weak var comicTitleLabel: UILabel!
    @IBOutlet private weak var storyTitleLabel: UILabel!
    @IBOutlet private weak var volumeIssueLabel: UILabel!

    static let reuseIdentifier = "myCollectionCell"

    func configure(comicTitle: String, storyTitle: String, volume: String, issueNumber: String, imageURL: String) {
        comicTitleLabel.text = comicTitle
        storyTitleLabel.text = storyTitle
        volumeIssueLabel.text = "Volume " + volume + ", Issue #" + issueNumber
        setImage(imageURL: imageURL)
    }

    // TO DO: load another image created by me if no comic book cover
    func setImage(imageURL: String?) {
        guard let imageURL = imageURL else { return }
        guard let url = URL(string: imageURL) else { return }
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        comicImageView.image = UIImage(data: data)
    }

    func setStyling() {
        comicImageView.clipsToBounds = true
        comicImageView.layer.cornerRadius = CGFloat(6.0)
    }

    func styleCell(whiteCellBackground: UIView) {
        contentView.backgroundColor = UIColor.white
        whiteCellBackground.layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.8])
        whiteCellBackground.layer.masksToBounds = false
        whiteCellBackground.layer.cornerRadius = 6.0
        whiteCellBackground.layer.shadowOffset = CGSize(width: 0, height: 4)
        whiteCellBackground.layer.shadowOpacity = 0.1
        whiteCellBackground.layer.shadowRadius = 18.0
        contentView.addSubview(whiteCellBackground)
        contentView.sendSubview(toBack: whiteCellBackground)
    }

    func removeSubviews() {
        for subview in subviews {
            subview.removeFromSuperview()
        }
    }
}
