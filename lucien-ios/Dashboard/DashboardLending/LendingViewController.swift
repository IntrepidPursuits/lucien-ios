//
//  LendingViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/9/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class LendingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet private weak var collectionView: UICollectionView!

    let objects = DashboardViewModel.lendingCellTitles
    let reuseIdentifier = LendingCollectionViewCell.lendingReuseIdentifier

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName: String(describing: LendingCollectionViewCell.self), bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        guard let lendingCell = cell as? LendingCollectionViewCell else { return cell }
        lendingCell.configure(comicTitle: objects[indexPath.item])
        return lendingCell
    }
}
