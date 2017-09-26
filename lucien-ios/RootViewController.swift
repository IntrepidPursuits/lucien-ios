//
//  RootViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 9/25/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit


final class RootViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet private weak var signInButton: GIDSignInButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        GIDSignIn.sharedInstance().uiDelegate = self
    }

    @IBAction func signInButtonPressed(_ sender: UIButton) {
        let startMyCollectionViewController = StartMyCollectionViewController()
        present(startMyCollectionViewController, animated: true, completion: nil)
    }
}
