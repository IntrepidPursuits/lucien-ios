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

    override func viewDidLoad() {
        super.viewDidLoad()
        emptyProfilePicture.contentMode = .scaleAspectFit
        logoutButton.backgroundColor = UIColor(red: 43/255, green: 45/255, blue: 66/255, alpha: 1.0)
        logoutButton.setTitleColor(UIColor.white, for: .normal)
        logoutButton.layer.cornerRadius = 3.0
    }
}
