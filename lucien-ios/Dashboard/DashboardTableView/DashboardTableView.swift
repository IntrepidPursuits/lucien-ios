//
//  DashboardTableView.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/20/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

protocol DashboardTableViewDelegate: class {
    func dashboardTableViewDidSelectComic(with viewModel: ComicDetailViewModel)
}

final class DashboardTableView: UITableView, UITableViewDataSource, UITableViewDelegate {

    var viewModel: DashboardTableViewModel?
    weak var dashboardDelegate: DashboardTableViewDelegate?
    let reuseIdentifier = DashboardTableViewCell.reuseIdentifier

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
        let nib = UINib(nibName: String(describing: DashboardTableViewCell.self), bundle: nil)
        register(nib, forCellReuseIdentifier: reuseIdentifier)
        contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 24, right: 16)
        separatorStyle = UITableViewCellSeparatorStyle.none
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getComicCount() ?? 0
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 116.0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        guard let configuredCell = cell as? DashboardTableViewCell else { return cell }

        let index = indexPath.item
        let comicTitle = viewModel?.getComicTitle(forIndex: index) ?? ""
        let storyTitle = viewModel?.getStoryTitle(forIndex: index) ?? ""
        let volume = viewModel?.getVolume(forIndex: index) ?? ""
        let issue = viewModel?.getIssueNumber(forIndex: index) ?? ""
        let imageURL = viewModel?.comicImageURL(forIndex: index) ?? ""
        configuredCell.configure(comicTitle: comicTitle, storyTitle: storyTitle, volume: volume, issueNumber: issue, imageURL: imageURL)

        tableView.contentSize = CGSize(width: tableView.frame.size.width - 32, height: tableView.contentSize.height)
        return configuredCell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let viewModel = viewModel else { return }
        dashboardDelegate?.dashboardTableViewDidSelectComic(with: viewModel.createComicDetailViewModel(forIndex: indexPath.item))
    }
}
