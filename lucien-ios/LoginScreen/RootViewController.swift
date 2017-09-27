//
//  RootViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 9/25/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController, GIDSignInUIDelegate, GIDSignInDelegate {
    @IBOutlet private weak var signInButton: GIDSignInButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addBackground()
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        signInButton.style = GIDSignInButtonStyle.wide
        GIDSignIn.sharedInstance().clientID = "1072472744835-miivpr72vpanvmpm2f3tbb7msae67tii.apps.googleusercontent.com"

    }

    @IBAction func signOutButton(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else { print("\(error.localizedDescription)"); return }
        guard (user.authentication.idToken) != nil else { return }
        let startMyCollectionViewController = StartMyCollectionViewController()
        present(startMyCollectionViewController, animated: true, completion: nil)
    }
}
