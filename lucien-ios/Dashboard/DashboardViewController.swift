//
//  DashboardViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/4/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController {

    @IBOutlet weak var dashboardScrollView: UIScrollView!

    let loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        print("In Dashboard VC")
        configureNavigationController()
    }

    private func configureNavigationController() {
        UINavigationBar.setNavBarBackground(navigationController: navigationController!)
        UINavigationBar.setNavBarTitle(navigationController: navigationController!, title: "Lucien")
        setViewProfileButton()
    }

    private func setViewProfileButton() {
        let viewProfileButton = UIBarButtonItem(image: UIImage(named: "smiley3"), style: .plain, target: self, action: #selector(DashboardViewController.viewProfileButtonPressed))
        navigationItem.leftBarButtonItem = viewProfileButton
    }

    @objc private func viewProfileButtonPressed() {
        let viewProfileController = ProfileViewController()
        self.navigationController?.pushViewController(viewProfileController, animated: true)

    }
}
