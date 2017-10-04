//
//  DashboardViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/4/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

class DashboardViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet weak var dashboardScrollView: UIScrollView!

    let loginViewModel = LoginViewModel()
    var scrollView: UIScrollView!
    var imageView: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        print("In Dashboard VC")
        configureNavigationController()

        imageView = UIImageView(image: UIImage(named: "image.png"))

        scrollView = UIScrollView(frame: view.bounds)
        scrollView.backgroundColor = UIColor.black
        scrollView.contentSize = imageView.bounds.size
//        scrollView.autoresizingMask = UInt8(UIViewImage) UInt8(UIViewAutoresizing.FlexibleWidth.rawValue) | UInt8(UIViewAutoresizing.FlexibleHeight.rawValue)

        scrollView.addSubview(imageView)
        view.addSubview(scrollView)

//        lendingScrollView = UIScrollView(frame: view.bounds)
//        lendingScrollView.backgroundColor = UIColor.black
//        lendingScrollView.autoresizingMask = UIViewAutoresizing.FlexibleWidth | UIViewAutoresizing.FlexibleHeight
//
//        lendingScrollView.addSubview(imageView)
//        view.addSubview(scrollView)
    }

    private func configureNavigationController() {
        UINavigationBar.setNavBarBackground(navigationController: navigationController!)
        UINavigationBar.setNavBarTitle(navigationController: navigationController!, title: "Lucien")
        setViewProfileButton()
    }

    private func setViewProfileButton() {
        let viewProfileButton = UIBarButtonItem(image: UIImage(named: "smiley3"), style: .plain, target: self, action: #selector(DashboardViewController.viewProfileButtonPressed))
        navigationItem.leftBarButtonItem = viewProfileButton
    }

    @objc private func viewProfileButtonPressed() {
        let viewProfileController = ProfileViewController()
        self.navigationController?.pushViewController(viewProfileController, animated: true)

    }

}
