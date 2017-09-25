//
//  RootViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 9/25/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class RootViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func signInButtonPressed(_ sender: UIButton) {
        let startMyCollectionViewController = UIViewController(nibName: "StartMyCollectionViewController", bundle: nil)
        present(startMyCollectionViewController, animated: true, completion: nil)
    }
}
