//
//  DashboardViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/4/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class DashboardViewController: UIViewController, UIScrollViewDelegate, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var dashboardScrollView: UIScrollView!
    @IBOutlet weak var lendingCollectionView: UICollectionView!

    let viewModel = DashboardViewModel()
    let objects = DashboardViewModel.lendingCellTitles
    let reuseIdentifier = LendingCollectionViewCell.lendingReuseIdentifier

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        viewModel.getDashboard {
            guard let dashboardData = self.viewModel.dashboardData else { return }
            debugPrint("in debug print \(dashboardData)")
        }
        lendingCollectionView.register(UINib(nibName: String(describing: LendingCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        lendingCollectionView.delegate = self
        lendingCollectionView.dataSource = self
        setLayout()
    }

    private func configureNavigationController() {
        navigationController?.navigationBar.setNavBarBackground()
        navigationItem.title = "Lucien"
        navigationController?.navigationBar.setNavBarTitle()
        setViewProfileButton()
    }

    private func setViewProfileButton() {
        let viewProfileButton = UIBarButtonItem(image: UIImage(named: "smiley3"), style: .plain, target: self, action: #selector(DashboardViewController.viewProfileButtonPressed))
        navigationItem.leftBarButtonItem = viewProfileButton
    }

    @objc private func viewProfileButtonPressed() {
        let viewProfileController = ProfileViewController()
        navigationController?.pushViewController(viewProfileController, animated: true)
    }

    func setLayout() {
        let collectionViewLayout = lendingCollectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let sectionInset = UIEdgeInsetsMake(0.0, 24.0, 0.0, 0.0)
        collectionViewLayout?.sectionInset = sectionInset
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 130.0, height: 286.0)
    }

    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 32.0
    }

    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 32.0
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        guard let lendingCell = cell as? LendingCollectionViewCell else { return cell}
        lendingCell.configure(comicTitle: objects[indexPath.item])
        return lendingCell
    }
}
