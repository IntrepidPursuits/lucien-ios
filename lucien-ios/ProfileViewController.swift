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

    override func viewDidLoad() {
        super.viewDidLoad()
        emptyProfilePicture.contentMode = .scaleAspectFit
    }
}
