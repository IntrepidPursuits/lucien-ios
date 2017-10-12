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
    @IBOutlet weak var lendingView: UIView!

    let loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        print("In Dashboard controller")
        loginViewModel.getDashboard {
            guard let dashboardData = self.loginViewModel.dashboardData else { return }
            debugPrint("in debug print \(dashboardData)")
        }
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
