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
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return (collectionViewModel?.getComicCount())!
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        guard let configuredCell = cell as? MyCollectionTableViewCell else { return cell }
        let index = indexPath.item
        let comicTitle = collectionViewModel?.getComicTitle(forIndex: index) ?? ""
        let storyTitle = collectionViewModel?.getStoryTitle(forIndex: index) ?? ""
        let volume = collectionViewModel?.getVolume(forIndex: index) ?? ""
        let issue = collectionViewModel?.getIssueNumber(forIndex: index) ?? ""
        configuredCell.configure(comicTitle: comicTitle, storyTitle: storyTitle, volume: volume, issueNumber: issue)
        return configuredCell
    }
}
