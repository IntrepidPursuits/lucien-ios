//
//  ProfileViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 9/27/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController {

    @IBOutlet weak var emptyProfilePicture: UIImageView!
    @IBOutlet weak var logoutButton: UIButton!
    @IBOutlet weak var nameTitle: UILabel!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var emailTitle: UILabel!
    @IBOutlet weak var email: UILabel!
    @IBOutlet weak var profileTitle: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        emptyProfilePicture.contentMode = .scaleAspectFit
        let dark = UIColor.black
        let coolGrey = UIColor.gray
        logoutButton.backgroundColor = dark
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        logoutButton.layer.cornerRadius = 3.0
        nameTitle.textColor = coolGrey
        emailTitle.textColor = coolGrey
        name.textColor = dark
        email.textColor = dark
        profileTitle.textColor = dark
    }
}
