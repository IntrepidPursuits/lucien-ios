//
//  AppDelegate.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 9/25/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit
import GoogleSignIn

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, GIDSignInDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = RootViewController()
        window.makeKeyAndVisible()

        // Initialize sign-in
        var configureError: NSError?
        GGLContext.sharedInstance().configureWithError(&configureError)
        GIDSignIn.sharedInstance().clientID = "1072472744835-miivpr72vpanvmpm2f3tbb7msae67tii.apps.googleusercontent.com"
        GIDSignIn.sharedInstance().delegate = self

        return true
    }

    private func application(application: UIApplication,
                             openURL url: URL, options: [UIApplicationOpenURLOptionsKey: AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handle(url as URL!,
                                                 sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
                                                 annotation: options[UIApplicationOpenURLOptionsKey.annotation])
    }

    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        if (error == nil) {
            print("signed in!")
            // Perform any operations on signed in user here.
            let userId = user.userID
            let idToken = user.authentication.idToken
            let fullName = user.profile.name
            let givenName = user.profile.givenName
            let familyName = user.profile.familyName
            let email = user.profile.email
            print(userId!, idToken!, fullName!, givenName!, familyName!, email!)
        } else {
            print("\(error.localizedDescription)")
        }
    }

    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
    }
}
