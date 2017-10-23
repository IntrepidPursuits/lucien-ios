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
        clearProfile()
        loginViewModel.getCurrentUser {
            guard let currentUser = self.loginViewModel.currentUser else { return }
            self.nameLabel.text = currentUser.firstName + " " + currentUser.lastName
            self.emailLabel.text = currentUser.email
            guard let profilePicURL = currentUser.googlePictureURL else {
                self.emptyProfilePicture.image = UIImage(named: "emptyProfile")
                return
            }
            self.setImage(imageURL: profilePicURL)
        }
        configureNavigationController()
        setUpStyling()
    }

    func clearProfile() {
        self.nameLabel.text = ""
        self.emailLabel.text = ""
        self.emptyProfilePicture.image = nil
    }

    @objc func back(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

    func setImage(imageURL: String) {
        guard let url = URL(string: imageURL) else { return }
        guard let data = try? Data(contentsOf: url) else { return }
        emptyProfilePicture.image = UIImage(data: data)
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
        clearProfile()
        let rootViewController = RootViewController()
        self.navigationController?.present(rootViewController, animated: true, completion: nil)
    }
}
