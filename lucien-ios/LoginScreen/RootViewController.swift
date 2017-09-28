//
//  RootViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 9/25/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController, GIDSignInDelegate, GIDSignInUIDelegate {
    @IBOutlet private weak var signInButton: GIDSignInButton!
    @IBOutlet weak var appName: UILabel!
    @IBOutlet weak var appDescription: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackground()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        signInButton.style = GIDSignInButtonStyle.wide
        appName.textColor = UIColor.white
        appDescription.textColor = UIColor.white
        GIDSignIn.sharedInstance().clientID = "1072472744835-miivpr72vpanvmpm2f3tbb7msae67tii.apps.googleusercontent.com"
    }

    @IBAction func signOutButtonPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
    }

    @IBAction func viewProfileButtonPressed(_ sender: UIButton) {
        let viewProfileController = ProfileViewController()
        present(viewProfileController, animated: true, completion: nil)
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else { print("\(error.localizedDescription)"); return }
        guard user.authentication.idToken != nil else { return }
        let startMyCollectionViewController = StartMyCollectionViewController()
        present(startMyCollectionViewController, animated: true, completion: nil)
        startMyCollectionViewController.transitioningDelegate = self
    }

    private func addBackground() {
        let width = UIScreen.main.bounds.size.width
        let height = UIScreen.main.bounds.size.height
        let homeScreenBackground = UIImageView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        homeScreenBackground.image = UIImage(named: "homeScreenImage")
        homeScreenBackground.contentMode = UIViewContentMode.scaleAspectFill

        view.addSubview(homeScreenBackground)
        view.sendSubview(toBack: homeScreenBackground)
    }
}

extension RootViewController: UIViewControllerTransitioningDelegate {

    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return AnimatedTransition()
    }

    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return nil
    }
}
