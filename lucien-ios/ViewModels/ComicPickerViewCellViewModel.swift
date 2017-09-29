//
//  ComicPickerViewCellViewModel.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 9/29/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation
import UIKit

//struct ComicPickerViewCellViewModel {
//    private let fieldTitleArray = [7:"CONDITION", 8: "GENRE"]
//    static let conditions = ["Near Mint",
//                             "Very Fine",
//                             "Fine",
//                             "Very Good",
//                             "Good",
//                             "Fair",
//                             "Poor"
//                            ]
//    static let genres = ["Action/Adventure",
//                         "Children’s",
//                         "Comedy",
//                         "Crime",
//                         "Drama",
//                         "Fantasy",
//                         "Graphic Novels",
//                         "Historical",
//                         "Horror",
//                         "LGTBQ",
//                         "Literature",
//                         "Manga",
//                         "Mature",
//                         "Movies & TV",
//                         "Music",
//                         "Mystery",
//                         "Non-Fiction",
//                         "Original Series",
//                         "Political",
//                         "Post-Apocalyptic",
//                         "Religious",
//                         "Romance",
//                         "School Life",
//                         "Science Fiction",
//                         "Slice of Life",
//                         "Superhero",
//                         "Supernatural/Occult",
//                         "Suspense",
//                         "Western"
//                        ]
//
//    /// Configures fonts, colors and border for a ComicReleaseDateCell
//    func configure(cell: ComicPickerViewTableViewCell) {
//        // Title Label Configuration
//        cell.titleLabel.font = UIFont(name: LucienTheme.Fonts.Muli.light.rawValue, size: 12)
//        cell.titleLabel.textColor = LucienTheme.coolGrey
//
//        // UIButton Configuration
//        cell.selectDateButton.setImage(UIImage(named: "dropDownArrow"), for: .normal)
//        cell.selectDateButton.semanticContentAttribute = .forceRightToLeft
//        cell.selectDateButton.imageEdgeInsets.left = cell.selectDateButton.frame.width - 24
//        cell.selectDateButton.tintColor = LucienTheme.dark
//    }
//
//    /// Retrieves a title for the field located at a specific row of the AddComicViewController's tableview.
//    func getTitleForCellAt(row: Int) -> String {
//        guard let titleText = fieldTitleArray[row] else {
//            return "Error"
//        }
//        return titleText
//    }
//}
