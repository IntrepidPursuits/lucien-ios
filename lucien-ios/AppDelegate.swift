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
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        let window = UIWindow(frame: UIScreen.main.bounds)
        self.window = window
        window.rootViewController = RootViewController()
        window.makeKeyAndVisible()

//        let navController = UINavigationController()
//        let rootController = RootViewController()
//        navController.viewControllers = [rootController]
//        self.window?.rootViewController = navController
//        self.window?.makeKeyAndVisible()

        return true

    }

    private func application(application: UIApplication, openURL url: URL, options: [UIApplicationOpenURLOptionsKey: AnyObject]) -> Bool {
        return GIDSignIn.sharedInstance().handle(
            url,
            sourceApplication: options[UIApplicationOpenURLOptionsKey.sourceApplication] as? String,
            annotation: options[UIApplicationOpenURLOptionsKey.annotation]
        )
    }
}
