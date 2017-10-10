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
        navigationController?.popViewController(animated: true)
    }

    private func configureNavigationController() {
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
        logoutButton.backgroundColor = LucienTheme.dark
        logoutButton.titleLabel?.font = LucienTheme.Fonts.muliBold(size: 13.0)
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        logoutButton.layer.cornerRadius = 3.0
        nameTitle.textColor = LucienTheme.coolGrey
        emailTitle.textColor = LucienTheme.coolGrey
        name.textColor = LucienTheme.dark
        email.textColor = LucienTheme.dark
        nameTitle.font = LucienTheme.Fonts.muliLight(size: 12.0)
        emailTitle.font = LucienTheme.Fonts.muliLight(size: 12.0)
        name.font = LucienTheme.Fonts.muliRegular(size: 18.0)
        email.font = LucienTheme.Fonts.muliRegular(size: 18.0)
    }
    
    @IBAction func logoutButtonPressed(_ sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        let rootViewController = RootViewController()
        self.navigationController?.present(rootViewController, animated: true, completion: nil)
    }
}
