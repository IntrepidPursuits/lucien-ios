//
//  LendingViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/9/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class LendingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    let reuseIdentifier = "comicCell"
    let objects = ["Princess", "Gracie", "Kittens"]

    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(UINib(nibName:"LendingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        collectionView.delegate = self
        collectionView.dataSource = self
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return objects.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        guard let lendingCell = cell as? LendingCollectionViewCell else { return cell}
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LendingCollectionViewCell else { return }
        configure(cell: lendingCell, lendedComicTitle: objects[indexPath.item])
        return lendingCell
    }

    func configure(cell: LendingCollectionViewCell, lendedComicTitle: String) {
        cell.lendedComicTitle.text = lendedComicTitle
    }
}
