//
//  DashboardViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/4/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class DashboardViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet private weak var dashboardScrollView: UIScrollView!
    @IBOutlet private weak var lendingCollectionView: DashboardCollectionView!
    @IBOutlet private weak var borrowingCollectionView: DashboardCollectionView!
    @IBOutlet private weak var lendingLabel: UILabel!
    @IBOutlet private weak var borrowingLabel: UILabel!
    @IBOutlet private weak var tableView: DashboardTableView!
    @IBOutlet private weak var myCollectionLabel: UILabel!
    @IBOutlet private weak var comicCountLabel: UILabel!

    var viewModel: DashboardViewModel

    init(dashboardViewModel: DashboardViewModel) {
        viewModel = dashboardViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        setViewModels()
        setStyling()
    }

    func setViewModels() {
        lendingCollectionView.collectionViewModel = viewModel.lendingViewModel
        borrowingCollectionView.collectionViewModel = viewModel.borrowingViewModel
        tableView.collectionViewModel = viewModel.myComicsViewModel
    }

    func setStyling() {
        lendingLabel.addTextSpacing(spacing: 0.5)
        borrowingLabel.addTextSpacing(spacing: 0.5)
        myCollectionLabel.addTextSpacing(spacing: 0.7)
        comicCountLabel.text = String(viewModel.myComicsViewModel.getComicCount()) + " Comics"
    }

    private func configureNavigationController() {
        navigationController?.navigationBar.setNavBarBackground()
        navigationItem.title = "Lucien"
        navigationController?.navigationBar.setNavBarTitle()
        setViewProfileButton()
        setAddBookButton()
    }

    private func setAddBookButton() {
        let addBookButton = UIBarButtonItem(image: UIImage(named: "plusIcon"), style: .plain, target: self, action: #selector(DashboardViewController.addBookButtonPressed))
        navigationItem.rightBarButtonItem = addBookButton
    }

    @objc private func addBookButtonPressed() {
        let addComicViewModel = ComicFormViewModel()
        let addBookViewController = ComicFormViewController(comicFormViewModel: addComicViewModel)
        navigationController?.pushViewController(addBookViewController, animated: true)
    }

    private func setViewProfileButton() {
        let viewProfileButton = UIBarButtonItem(image: UIImage(named: "smiley3"), style: .plain, target: self, action: #selector(DashboardViewController.viewProfileButtonPressed))
        navigationItem.leftBarButtonItem = viewProfileButton
    }

    @objc private func viewProfileButtonPressed() {
        let viewProfileController = ProfileViewController()
        navigationController?.pushViewController(viewProfileController, animated: true)
    }
}
