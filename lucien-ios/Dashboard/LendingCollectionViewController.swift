//
//  LendingViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/9/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class LendingCollectionViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!

    let reuseIdentifier = "comicCell"
    let objects = ["Princess", "Gracie", "Kittens"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName:"LendingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        setLayout()
    }

    func setLayout() {
        let collectionViewLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout
        let sectionInset = UIEdgeInsetsMake(0.0, 24.0, 0.0, 0.0)
        collectionViewLayout?.sectionInset = sectionInset
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int { return 1 }

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
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! LendingCollectionViewCell else { return }
        configure(cell: lendingCell, lendedComicTitle: objects[indexPath.item])
        return lendingCell
    }

    func configure(cell: LendingCollectionViewCell, lendedComicTitle: String) {
        cell.lendedComicTitle.text = lendedComicTitle
    }
}
