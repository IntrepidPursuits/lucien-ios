//
//  StartMyCollectionViewController.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 9/25/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class StartMyCollectionViewController: UIViewController {

    @IBOutlet private weak var addBookButton: UIButton!
    @IBOutlet private weak var welcomeImageView: UIImageView!
    @IBOutlet private weak var toDashboardButton: UIButton!
    @IBOutlet private weak var getStartedDescription: UILabel!
    @IBOutlet private weak var welcomeLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyling()
    }

    func setUpStyling() {
        welcomeLabel.font = LucienTheme.Fonts.muliExtraLightItalic(size: CGFloat(48.0))
        welcomeLabel.textColor = LucienTheme.dark
        welcomeLabel.addTextSpacing(spacing: 1.2)
        getStartedDescription.textColor = LucienTheme.dark
        getStartedDescription.font = LucienTheme.Fonts.muliSemiBold(size: CGFloat(18.0))
        getStartedDescription.lineBreakMode = .byWordWrapping
        getStartedDescription.numberOfLines = 0
        toDashboardButton.titleLabel?.addTextSpacing(spacing: 1.0)
        toDashboardButton.setTitleColor(LucienTheme.dark, for: .normal)
        toDashboardButton.layer.borderColor = LucienTheme.dark.cgColor
        toDashboardButton.layer.cornerRadius = CGFloat(3.0)
        toDashboardButton.titleLabel?.font = LucienTheme.Fonts.muliBold(size: CGFloat(13.0))
        toDashboardButton.layer.borderWidth = CGFloat(1.0)
        addBookButton.titleLabel?.addTextSpacing(spacing: 1.0)
        addBookButton.backgroundColor = LucienTheme.dark
        addBookButton.layer.cornerRadius = CGFloat(3.0)
        addBookButton.titleLabel?.textColor = LucienTheme.white
        addBookButton.titleLabel?.font = LucienTheme.Fonts.muliBold(size: CGFloat(13.0))
    }

    @IBAction func startCollectionButtonPressed(_ sender: UIButton) {
        let addComicViewController = AddComicViewController()
        let addComicNavigationController = UINavigationController(rootViewController: addComicViewController)
        present(addComicNavigationController, animated: true, completion: nil)
    }

    @IBAction func dashboardButtonPressed(_ sender: UIButton) {
        let dashboardViewController = DashboardViewController()
        let dashboardNavigationController = UINavigationController(rootViewController: dashboardViewController)
        present(dashboardNavigationController, animated: true, completion: nil)
    }
}
