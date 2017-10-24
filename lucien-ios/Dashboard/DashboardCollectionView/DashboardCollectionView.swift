//
//  CollectionViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/13/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class DashboardCollectionView: UICollectionView, UICollectionViewDataSource, UICollectionViewDelegate {

    var collectionViewModel: DashboardCollectionViewModel?
    let reuseIdentifier = DashboardCollectionViewCell.reuseIdentifier

    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: layout)
        initializeView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }

    func initializeView() {
        dataSource = self
        delegate = self
        let nib = UINib(nibName: String(describing: DashboardCollectionViewCell.self), bundle: nil)
        register(nib, forCellWithReuseIdentifier: reuseIdentifier)
        setLayout()
    }

    func setLayout() {
        let collectionViewLayout = self.collectionViewLayout as? UICollectionViewFlowLayout
        let sectionInset = UIEdgeInsets(top: 0, left: 24, bottom: 0, right: 0)
        collectionViewLayout?.sectionInset = sectionInset
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        guard let cellCount = collectionViewModel?.getComicCount() else { return 0 }
        return cellCount
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath)
        guard let configuredCell = cell as? DashboardCollectionViewCell else { return cell}
        let index = indexPath.item
        let userTypeText = collectionViewModel?.getUserTypeText(forIndex: index) ?? ""
        let storyTitle = collectionViewModel?.getStoryTitle(forIndex: index) ?? ""
        let comicDueDate = collectionViewModel?.getComicDueDate(forIndex: index)
        let userName = collectionViewModel?.comicPerson(forIndex: index) ?? "No name found"
        let imageURL = collectionViewModel?.comicImageURL(forIndex: index)
        configuredCell.configure(userTypeText: userTypeText,
                                 comicDueDate: comicDueDate,
                                 ownerBorrowerName: userName,
                                 imageURL: imageURL, storyTitle: storyTitle)
        return configuredCell
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
