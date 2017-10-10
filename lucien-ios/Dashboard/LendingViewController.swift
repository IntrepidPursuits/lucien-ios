//
//  LendingViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/9/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

class LendingViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {

    @IBOutlet weak var collectionView: UICollectionView!

    let reuseIdentifier = "cell"
    let objects = ["Princess", "Gracie", "Kittens"]

    override func viewDidLoad() {
        super.viewDidLoad()
        self.collectionView.register(UINib(nibName:"LendingCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
    }

    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.objects.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as? LendingCollectionViewCell
        cell?.cellieLabel.text = self.objects[indexPath.item]

        return cell!
    }
}
