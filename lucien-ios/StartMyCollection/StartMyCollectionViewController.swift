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
    @IBOutlet private weak var getStartedDescriptionLabel: UILabel!
    @IBOutlet private weak var welcomeLabel: UILabel!

    let lucienAPIClient = LucienAPIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpStyling()
    }

    func setUpStyling() {
        setUpWelcomeLabel()
        setUpToDashboardButton()
        setUpAddBookButton()
    }

    func setUpWelcomeLabel() {
        welcomeLabel.addTextSpacing(spacing: 1.2)
    }

    func setUpToDashboardButton() {
        toDashboardButton.titleLabel?.addTextSpacing(spacing: 1.0)
        toDashboardButton.layer.borderColor = LucienTheme.dark.cgColor
        toDashboardButton.layer.cornerRadius = CGFloat(3.0)
        toDashboardButton.layer.borderWidth = CGFloat(1.0)
    }

    func setUpAddBookButton() {
        addBookButton.titleLabel?.addTextSpacing(spacing: 1.0)
        addBookButton.layer.cornerRadius = CGFloat(3.0)
    }

    @IBAction func startCollectionButtonPressed(_ sender: UIButton) {
        let comicFormViewController = ComicFormViewController(comicFormViewModel: ComicFormViewModel())
        let comicFormViewControllerNavigationController = UINavigationController(rootViewController: comicFormViewController)
        present(comicFormViewControllerNavigationController, animated: true, completion: nil)
    }

    @IBAction func dashboardButtonPressed(_ sender: UIButton) {
        lucienAPIClient.getDashboard { response in
            switch response {
            case .success(let result):
                let viewModel = DashboardViewModel(dashboard: result)
                let dashboardViewController = DashboardViewController(dashboardViewModel: viewModel)
                let dashboardNavigationController = UINavigationController(rootViewController: dashboardViewController)
                self.present(dashboardNavigationController, animated: true, completion: nil)
            case .failure(let error):
                print(error)
            }
        }
    }
}
