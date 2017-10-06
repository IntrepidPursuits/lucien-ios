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
    @IBOutlet private weak var appName: UILabel!
    @IBOutlet private weak var appDescription: UILabel!

    let loginViewModel = LoginViewModel()
    let lucienAPIClient = LucienAPIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackground()
        signInButton.style = GIDSignInButtonStyle.wide
        appName.textColor = UIColor.white
        appDescription.textColor = UIColor.white
        GIDSignIn.sharedInstance().uiDelegate = self
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().clientID = "1072472744835-miivpr72vpanvmpm2f3tbb7msae67tii.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().scopes.append("profile")
    }

    @IBAction func signOutButtonPressed(_ sender: Any) {
        GIDSignIn.sharedInstance().signOut()
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

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        guard error == nil else { print("\(error.localizedDescription)"); return }
        guard let idToken = user.authentication.idToken else { return }
        loginViewModel.authenticateUser(code: idToken) {
            self.loginViewModel.getDashboard {
                guard let myDashboard = self.loginViewModel.dashboardData else { return }
                let myCollectionCount = myDashboard.myCollectionCount
                myCollectionCount == 0 ? self.showStartMyCollection() : self.showDashboard()
            }
        }
    }

    func showDashboard() {
        let dashboardViewController = DashboardViewController()
        let dashboardNavigationController = UINavigationController(rootViewController: dashboardViewController)
        present(dashboardNavigationController, animated: true, completion: nil)
    }

    func showStartMyCollection() {
        let startMyCollectionViewController = StartMyCollectionViewController()
        present(startMyCollectionViewController, animated: true, completion: nil)
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
