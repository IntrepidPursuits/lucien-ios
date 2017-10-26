//
//  LendingSuccessViewController.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/25/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

class LendingSuccessViewController: UIViewController, AlertDisplaying {

    // MARK: - Private IBOutlets

    @IBOutlet private weak var lendingLabel: UILabel!
    @IBOutlet private weak var goToDashboardButton: UIButton!
    @IBOutlet weak var comicBookImageView: UIImageView!

    // MARK: - Variables

    var lendingLabelText: String?
    var comicCoverPhoto: UIImage?

    // MARK: - Contants

    let lucienAPIClient = LucienAPIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureLendingLabel()
        configureComicBookImageView()
        configureDashboardButton()
    }

    // MARK: - Private Instance Methods

    private func configureLendingLabel() {
        lendingLabel.adjustsFontSizeToFitWidth = true

        if let lendingLabelText = lendingLabelText {
            lendingLabel.text = lendingLabelText
        }
    }

    private func configureComicBookImageView() {
        if let comicCoverPhoto = comicCoverPhoto {
            comicBookImageView.image = comicCoverPhoto
        }

        comicBookImageView.layer.cornerRadius = LucienConstants.comicCoverPhotoCornerRadius
        comicBookImageView.clipsToBounds = true
    }

    private func configureDashboardButton() {
        goToDashboardButton.titleLabel?.addTextSpacing(spacing: LucienConstants.dashboardButtonTextSpacing)
        goToDashboardButton.layer.borderColor = LucienTheme.dark.cgColor
        goToDashboardButton.layer.cornerRadius = LucienConstants.dashboardButtonCornerRadius
        goToDashboardButton.layer.borderWidth = LucienConstants.dashboardButtonBorderWidth
    }

    // MARK: - IBAction Methods

    @IBAction func goToDashboardButtonTapped(_ sender: UIButton) {
        let alertController = UIAlertController(title: "Error",
                                                message: "Our service is currently encountering an issue. Please ensure that you are connected to the internet and try again.",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { _ in }
        alertController.addAction(okAction)
        var dashboardComics = [DashboardComicUser]()
        lucienAPIClient.getMyComics { [weak self] response in
            switch response {
            case .success(let result):
                DispatchQueue.main.async {
                    dashboardComics = result
                    self?.lucienAPIClient.getDashboard { response in
                        switch response {
                        case .success(let result):
                            let viewModel = DashboardViewModel(dashboard: result, myComics: dashboardComics)
                            let dashboardViewController = DashboardViewController(dashboardViewModel: viewModel)
                            let dashboardNavigationController = UINavigationController(rootViewController: dashboardViewController)
                            self?.present(dashboardNavigationController, animated: true, completion: nil)
                        case .failure:
                            self?.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            case .failure:
                self?.present(alertController, animated: true, completion: nil)
            }
        }
    }
}
