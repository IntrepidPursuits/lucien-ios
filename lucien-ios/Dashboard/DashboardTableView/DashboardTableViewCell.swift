//
//  DashboardTableViewCell.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/23/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class DashboardTableViewCell: UITableViewCell {

    @IBOutlet private weak var comicImageView: UIImageView!
    @IBOutlet private weak var comicTitleLabel: UILabel!
    @IBOutlet private weak var storyTitleLabel: UILabel!
    @IBOutlet private weak var volumeIssueLabel: UILabel!

    static let reuseIdentifier = "myCollectionCell"
    private var subview: UIView?

    func configure(comicTitle: String, storyTitle: String, volume: String, issueNumber: String, imageURL: String) {
        comicTitleLabel.text = comicTitle
        storyTitleLabel.text = storyTitle
        volumeIssueLabel.text = "Volume " + volume + ", Issue #" + issueNumber
        setImage(imageURL: imageURL)
        setStyling()
    }

    // TO DO: load another image created by me if no comic book cover
    func setImage(imageURL: String?) {
        guard let imageURL = imageURL,
            let url = URL(string: imageURL),
            let data = try? Data(contentsOf: url) else {
                return
        }
        comicImageView.image = UIImage(data: data)
    }

    func setStyling() {
        comicImageView.clipsToBounds = true
        comicImageView.layer.cornerRadius = CGFloat(6.0)
        selectionStyle = .none
        guard let comicTitle = comicTitleLabel.text else { return }
        comicTitleLabel.setLineHeight(text: comicTitle, lineSpacing: 0.1)
        if subview == nil {
            let subview = UIView(frame: CGRect(x: 0, y: 16, width: contentView.frame.size.width - 32, height: 100))
            contentView.addSubview(subview)
            contentView.sendSubview(toBack: subview)
            self.subview = subview
            styleCell()
        }
    }

    func styleCell() {
        contentView.backgroundColor = UIColor.white
        layer.backgroundColor = CGColor(colorSpace: CGColorSpaceCreateDeviceRGB(), components: [1.0, 1.0, 1.0, 0.8])
        layer.masksToBounds = false
        layer.cornerRadius = 6.0
        layer.shadowOffset = CGSize(width: 0, height: 4)
        layer.shadowOpacity = 0.1
        layer.shadowRadius = 18.0
    }
}
