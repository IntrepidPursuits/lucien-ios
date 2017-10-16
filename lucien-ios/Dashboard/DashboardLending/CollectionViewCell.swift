//
//  LendingCollectionViewCell.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/10/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class CollectionViewCell: UICollectionViewCell {

    @IBOutlet private weak var dueDateLabel: UILabel!
    @IBOutlet weak var borrowerNameLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!

    static let reuseIdentifier = "comicCell"

    func configure(comicDueDate: Date, borrowerName: String, imageURL: String) {
        dueDateLabel.text = formatDateToString(date: comicDueDate)
        borrowerNameLabel.text = borrowerName
        setImage(imageURL: imageURL)
        setStyling()
    }

    func setImage(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        bookImage.image = UIImage(data: data)
    }

    func formatDateToString(date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "LLL. dd"
        let formattedDate = formatter.string(from: date)
        return "Due " + formattedDate
    }

    func setStyling() {
//        bookImage.layer.masksToBounds = true
        bookImage.clipsToBounds = true
        bookImage.layer.cornerRadius = CGFloat(6.0)
    }
}
