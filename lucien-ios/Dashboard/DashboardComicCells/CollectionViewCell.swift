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
    @IBOutlet weak var ownerBorrowerNameLabel: UILabel!
    @IBOutlet weak var bookImage: UIImageView!
    @IBOutlet weak var lentOrBorrowedLabel: UILabel!
    @IBOutlet weak var ownerOrBorrowerLabel: UILabel!

    static let reuseIdentifier = "comicCell"

    func configure(userType: String, comicDueDate: Date?, ownerBorrowerName: String, imageURL: String?) {
        dueDateLabel.text = formatDateToString(date: comicDueDate)
        configureLentOrBorrowedLabel(userType: userType)
        ownerBorrowerNameLabel.text = ownerBorrowerName
        setImage(imageURL: imageURL)
        setStyling()
    }

    func configureLentOrBorrowedLabel(userType: String) {
        switch userType {
        case "borrower":
            lentOrBorrowedLabel.text = "LENT TO"
        case "owner":
            lentOrBorrowedLabel.text = "BORROWED FROM"
        default:
            lentOrBorrowedLabel.text = ""
        }
    }

    // TO DO: load another image created by me if no comic book cover
    func setImage(imageURL: String?) {
        guard let url = URL(string: imageURL!) else { return }
        let sampleImageData = try? Data(contentsOf: URL(string: "https://www.petsworld.in/blog/wp-content/uploads/2014/09/adorable-cat.jpg")!)
        guard let data = try? Data(contentsOf: url) else {
            bookImage.image = UIImage(data: sampleImageData!)
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
