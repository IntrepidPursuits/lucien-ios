//
//  CollectionViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/13/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

class DashboardCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    let viewModel = DashboardCollectionViewModel()
    let reuseIdentifier = CollectionViewCell.reuseIdentifier

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        self.dataSource = self
        self.delegate = self
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        setLayout()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.dataSource = self
        self.delegate = self
        let nib = UINib(nibName: "CollectionViewCell", bundle: nil)
        self.register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        setLayout()
    }

    func setLayout() {
        let collectionViewLayout = self.collectionViewLayout as? UICollectionViewFlowLayout
        let sectionInset = UIEdgeInsetsMake(0.0, 24.0, 0.0, 0.0)
        collectionViewLayout?.sectionInset = sectionInset
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getComicCount()
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        guard let lendingCell = cell as? CollectionViewCell else { return cell}
        let index = indexPath.item
        lendingCell.configure(comicDueDate: viewModel.comicDueDate(forIndex: index), borrowerName: viewModel.comicBorrower(forIndex: index), imageURL: viewModel.comicImageURL(forIndex: index))
        return lendingCell
    }
}

extension DashboardCollectionView: UICollectionViewDelegateFlowLayout {
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
}
