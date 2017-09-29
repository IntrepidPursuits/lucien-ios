//
//  StartMyCollectionViewController.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 9/25/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class StartMyCollectionViewController: UIViewController {
    @IBAction func startCollectionButtonPressed(_ sender: UIButton) {
        let addComicViewController = AddComicViewController()
        let addComicNavigationController = UINavigationController(rootViewController: addComicViewController)

        // NavigationBar Background
        addComicNavigationController.navigationBar.backgroundColor = LucienTheme.white
        addComicNavigationController.navigationBar.setValue(true, forKey: "hidesShadow")

        // NavigationBar Title
        addComicNavigationController.viewControllers[0].title = "Add Book"
        addComicNavigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: UIFont(name: LucienTheme.Fonts.PermanentMarker.regular.rawValue, size: 30)!]

        // NavigationBar Back Button
        let backButton = UIBarButtonItem(image: UIImage(named: "navBackButton"), style: .plain, target: self, action: #selector(StartMyCollectionViewController.backButtonTapped))
        backButton.tintColor = UIColor.black
        addComicViewController.navigationItem.leftBarButtonItem = backButton

        // NavigationBar 'Finish' Button
        let finishButton = UIBarButtonItem(title: "Finish", style: .plain, target: self, action: nil)
        finishButton.setTitleTextAttributes([NSAttributedStringKey.font: UIFont(name: LucienTheme.Fonts.Muli.semiBold.rawValue, size: 17)!], for: .normal)
        finishButton.tintColor = LucienTheme.finishButtonBlack
        addComicViewController.navigationItem.rightBarButtonItem = finishButton

        present(addComicNavigationController, animated: true, completion: nil)
    }

    @objc func backButtonTapped(){
        dismiss(animated: true, completion: nil)
    }
}
