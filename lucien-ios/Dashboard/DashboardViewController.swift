//
//  DashboardViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/4/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class DashboardViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var dashboardScrollView: UIScrollView!
    @IBOutlet weak var lendingCollectionView: DashboardCollectionView!
    @IBOutlet weak var borrowingCollectionView: DashboardCollectionView!
    @IBOutlet weak var lendingLabel: UILabel!
    @IBOutlet weak var borrowingLabel: UILabel!

    let viewModel = DashboardViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        setUpStyling()
        lendingCollectionView.viewModel.collectionViewType = "lending"
        borrowingCollectionView.viewModel.collectionViewType = "borrowing"
    }

    func setUpStyling() {
        lendingLabel.addTextSpacing(spacing: 0.5)
        borrowingLabel.addTextSpacing(spacing: 0.5)
    }

    private func configureNavigationController() {
        navigationController?.navigationBar.setNavBarBackground()
        navigationItem.title = "Lucien"
        navigationController?.navigationBar.setNavBarTitle()
        setViewProfileButton()
    }

    private func setViewProfileButton() {
        let viewProfileButton = UIBarButtonItem(image: UIImage(named: "smiley3"), style: .plain, target: self, action: #selector(DashboardViewController.viewProfileButtonPressed))
        navigationItem.leftBarButtonItem = viewProfileButton
    }

    @objc private func viewProfileButtonPressed() {
        let viewProfileController = ProfileViewController()
        navigationController?.pushViewController(viewProfileController, animated: true)
    }
}
