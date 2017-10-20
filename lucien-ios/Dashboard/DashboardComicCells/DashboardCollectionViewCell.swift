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

    static let reuseIdentifier = "comicCell"

    func configure(userTypeText: String, comicDueDate: Date?, ownerBorrowerName: String, imageURL: String?) {
        dueDateLabel.text = formatDateToString(date: comicDueDate)
        lentOrBorrowedLabel.text = userTypeText
        ownerBorrowerNameLabel.text = ownerBorrowerName
        setImage(imageURL: imageURL)
        setStyling()
    }

    // TO DO: load another image created by me if no comic book cover
    func setImage(imageURL: String?) {
        guard let imageURL = imageURL else { return }
        guard let url = URL(string: imageURL) else { return }
        guard let data = try? Data(contentsOf: url) else {
            return
        }
        bookImage.image = UIImage(data: data)
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
