//
//  DashboardTableView.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/20/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class DashboardTableView: UITableView, UITableViewDataSource, UITableViewDelegate {

    var collectionViewModel: DashboardCollectionViewModel?
    let reuseIdentifier = MyCollectionTableViewCell.reuseIdentifier

    override init(frame: CGRect, style: UITableViewStyle) {
        super.init(frame: frame, style: style)
        initializeView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }

    func initializeView() {
        delegate = self
        dataSource = self
        let nib = UINib(nibName: String(describing: MyCollectionTableViewCell.self), bundle: nil)
        register(nib, forCellReuseIdentifier: reuseIdentifier)
        self.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16)
        self.separatorStyle = UITableViewCellSeparatorStyle.none
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (collectionViewModel?.getComicCount())!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        guard let configuredCell = cell as? MyCollectionTableViewCell else { return cell }
        let index = indexPath.item
        let comicTitle = collectionViewModel?.getComicTitle(forIndex: index) ?? ""
        let storyTitle = collectionViewModel?.getStoryTitle(forIndex: index) ?? ""
        let volume = collectionViewModel?.getVolume(forIndex: index) ?? ""
        let issue = collectionViewModel?.getIssueNumber(forIndex: index) ?? ""
        let imageURL = collectionViewModel?.comicImageURL(forIndex: index) ?? ""
        configuredCell.configure(comicTitle: comicTitle, storyTitle: storyTitle, volume: volume, issueNumber: issue, imageURL: imageURL)

        let whiteCellBackground = UIView(frame: CGRect(x: 0, y: 16, width: tableView.frame.size.width - 32, height: 100))
        configuredCell.styleCell(whiteCellBackground: whiteCellBackground)

        tableView.contentSize = CGSize(width: tableView.frame.size.width - 32, height: tableView.contentSize.height)
        return configuredCell
    }
}
