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
        self.view.backgroundColor = UIColor(patternImage: UIImage(named:"homeScreenImage")!)
        GIDSignIn.sharedInstance().uiDelegate = self
        signInButton.style = GIDSignInButtonStyle.wide
    }

//    @IBAction func signInButtonPressed(_ sender: UIButton) {
//        let startMyCollectionViewController = StartMyCollectionViewController()
//        present(startMyCollectionViewController, animated: true, completion: nil)

    @IBAction func signOutButton(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
    }
}
