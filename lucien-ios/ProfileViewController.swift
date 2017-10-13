//
//  ProfileViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 9/27/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class ProfileViewController: UIViewController {

    @IBOutlet private weak var emptyProfilePicture: UIImageView!
    @IBOutlet private weak var logoutButton: UIButton!
    @IBOutlet private weak var nameTitleLabel: UILabel!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var emailTitleLabel: UILabel!
    @IBOutlet private weak var emailLabel: UILabel!

    let loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        loginViewModel.getCurrentUser {
            guard let currentUser = self.loginViewModel.currentUser else { return }
            self.nameLabel.text = currentUser.firstName + " " + currentUser.lastName
            self.emailLabel.text = currentUser.email
        }
        setUpStyling()
    }

    @objc func back(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

    private func configureNavigationController() {
        navigationItem.title = "Profile"
        navigationController?.navigationBar.setNavBarTitle()
        navigationController?.navigationBar.setNavBarBackground()
        setNavBarBackButton()
    }

    private func setNavBarBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(named: "navBackButton"), style: .plain, target: self, action: #selector(back(sender:)))
        backButton.tintColor = LucienTheme.dark
        navigationItem.leftBarButtonItem = backButton
    }

    private func setUpStyling() {
        emptyProfilePicture.contentMode = .scaleAspectFit
        logoutButton.layer.cornerRadius = 3.0
    }

    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        let rootViewController = RootViewController()
        self.navigationController?.present(rootViewController, animated: true, completion: nil)
    }
}
