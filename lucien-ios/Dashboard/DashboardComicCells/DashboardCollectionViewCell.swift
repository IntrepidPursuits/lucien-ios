//
//  DashboardCollectionViewCell.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/10/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class DashboardCollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var dueDateLabel: UILabel!
    @IBOutlet private weak var ownerBorrowerNameLabel: UILabel!
    @IBOutlet private weak var bookImage: UIImageView!
    @IBOutlet private weak var lentOrBorrowedLabel: UILabel!
    @IBOutlet private weak var ownerOrBorrowerLabel: UILabel!
    @IBOutlet private weak var initialLabel: UILabel!
    @IBOutlet private weak var storyTitleLabel: UILabel!

    static let reuseIdentifier = "comicCell"

    func configure(userTypeText: String, comicDueDate: Date?, ownerBorrowerName: String, imageURL: String?, storyTitle: String) {
        dueDateLabel.text = formatDateToString(date: comicDueDate)
        lentOrBorrowedLabel.text = userTypeText
        ownerBorrowerNameLabel.text = ownerBorrowerName
        setImage(imageURL: imageURL, storyTitle: storyTitle)
        setStyling()
    }

    // TO DO: load another image created by me if no comic book cover
    func setImage(imageURL: String?, storyTitle: String) {
        guard let imageURL = imageURL else {
            setNoCoverImage(storyTitle: storyTitle)
            return
        }
        guard let url = URL(string: imageURL) else {
            setNoCoverImage(storyTitle: storyTitle)
            return
        }
        guard let data = try? Data(contentsOf: url) else {
            setNoCoverImage(storyTitle: storyTitle)
            return
        }
        bookImage.image = UIImage(data: data)
        initialLabel.text = ""
        storyTitleLabel.text = ""
    }

    func setNoCoverImage(storyTitle: String) {
        bookImage.backgroundColor = LucienTheme.dark
        storyTitleLabel.text = storyTitle.localizedUppercase
        let index = storyTitle.index(storyTitle.startIndex, offsetBy: 0)
        let initial = String(storyTitle[index])
        initialLabel.text = initial.localizedUppercase
    }

    func formatDateToString(date: Date?) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL. dd"
        guard let date: Date = date else { return "No due date" }
        return "Due " + formatter.string(from: date)
    }

    func setStyling() {
        bookImage.clipsToBounds = true
        bookImage.layer.cornerRadius = CGFloat(7.0)
    }
}
