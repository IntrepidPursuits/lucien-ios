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

    let lucienAPIClient = LucienAPIClient()

    override func viewDidLoad() {
        super.viewDidLoad()
        addBackground()
        GIDSignIn.sharedInstance().delegate = self
        GIDSignIn.sharedInstance().uiDelegate = self
        signInButton.style = GIDSignInButtonStyle.wide
        appName.textColor = UIColor.white
        appDescription.textColor = UIColor.white
        GIDSignIn.sharedInstance().clientID = "1072472744835-miivpr72vpanvmpm2f3tbb7msae67tii.apps.googleusercontent.com"
        print(GIDSignIn.sharedInstance().scopes)
        GIDSignIn.sharedInstance().scopes.append("profile")
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
//        guard let idToken = user.authentication.idToken else { return }
        let startMyCollectionViewController = StartMyCollectionViewController()
        present(startMyCollectionViewController, animated: true, completion: nil)
        //startMyCollectionViewController.transitioningDelegate = self // this is currently preventing full screen transition from login to collection screen

        lucienAPIClient.getCurrentUser { response in
            switch response {
            case .success(let json):
                print(json)
            case .failure(let error):
                print(error)
            }

        }
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
