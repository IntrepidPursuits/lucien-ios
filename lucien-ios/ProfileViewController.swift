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
    @IBOutlet private weak var nameTitle: UILabel!
    @IBOutlet private weak var name: UILabel!
    @IBOutlet private weak var emailTitle: UILabel!
    @IBOutlet private weak var email: UILabel!

    let loginViewModel = LoginViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        loginViewModel.getCurrentUser {
            guard let currentUser = self.loginViewModel.currentUser else { return }
            debugPrint("in debug print \(currentUser)")
            self.name.text = currentUser.firstName + " " + currentUser.lastName
            self.email.text = currentUser.email
        }
        setUpStyling()
    }

    @objc func back(sender: UIBarButtonItem) {
        self.navigationController?.popViewController(animated: true)
        UINavigationBar.setNavBarTitle(navigationController: self.navigationController!, title: "Lucien")
    }

    private func configureNavigationController() {
        guard self.navigationController != nil else { return }
        UINavigationBar.setNavBarBackground(navigationController: self.navigationController!)
        UINavigationBar.setNavBarTitle(navigationController: self.navigationController!, title: "Profile")
        setNavBarBackButton()
    }

    private func setNavBarBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(named: "navBackButton"), style: .plain, target: self, action: #selector(back(sender:)))
        backButton.tintColor = LucienTheme.dark
        self.navigationItem.leftBarButtonItem = backButton
    }

    private func setUpStyling() {
        emptyProfilePicture.contentMode = .scaleAspectFit
        logoutButton.backgroundColor = LucienTheme.dark
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        logoutButton.layer.cornerRadius = 3.0
        nameTitle.textColor = LucienTheme.coolGrey
        emailTitle.textColor = LucienTheme.coolGrey
        name.textColor = LucienTheme.dark
        email.textColor = LucienTheme.dark
    }
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        let rootViewController = RootViewController()
        self.navigationController?.present(rootViewController, animated: true, completion: nil)
    }
}
