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
    @IBOutlet private weak var profileTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        emptyProfilePicture.contentMode = .scaleAspectFit
        logoutButton.backgroundColor = LucienTheme.dark
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        logoutButton.layer.cornerRadius = 3.0
        nameTitle.textColor = LucienTheme.coolGrey
        emailTitle.textColor = LucienTheme.coolGrey
        name.textColor = LucienTheme.dark
        email.textColor = LucienTheme.dark
        profileTitle.textColor = LucienTheme.dark
    }
}
