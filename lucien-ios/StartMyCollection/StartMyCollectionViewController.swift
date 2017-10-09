//
//  StartMyCollectionViewController.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 9/25/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class StartMyCollectionViewController: UIViewController {

    @IBOutlet weak var addBook: UIButton!
    @IBOutlet weak var welcomeImage: UIImageView!
    @IBOutlet weak var toDashboard: UIButton!
    @IBOutlet weak var getStartedDescription: UILabel!
    @IBOutlet weak var welcome: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyling()
    }

    func setUpStyling() {
        welcome.font = LucienTheme.Fonts.muliExtraLightItalic(size: CGFloat(48.0))
        welcome.textColor = LucienTheme.dark
        welcome.addTextSpacing(amount: 1.2)
        getStartedDescription.textColor = LucienTheme.dark
        getStartedDescription.font = LucienTheme.Fonts.muliSemiBold(size: CGFloat(18.0))
        getStartedDescription.lineBreakMode = .byWordWrapping
        getStartedDescription.numberOfLines = 0
        toDashboard.titleLabel?.addTextSpacing(amount: 1.0)
        toDashboard.setTitleColor(LucienTheme.dark, for: .normal)
        toDashboard.layer.borderColor = LucienTheme.dark.cgColor
        toDashboard.layer.cornerRadius = CGFloat(3.0)
        toDashboard.titleLabel?.font = LucienTheme.Fonts.muliBold(size: CGFloat(13.0))
        toDashboard.layer.borderWidth = CGFloat(1.0)
        addBook.titleLabel?.addTextSpacing(amount: 1.0)
        addBook.backgroundColor = LucienTheme.dark
        addBook.layer.cornerRadius = CGFloat(3.0)
        addBook.titleLabel?.textColor = LucienTheme.white
        addBook.titleLabel?.font = LucienTheme.Fonts.muliBold(size: CGFloat(13.0))
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
