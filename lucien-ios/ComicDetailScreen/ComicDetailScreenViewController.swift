//
//  ComicDetailScreenViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/24/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class ComicDetailScreenViewController: UIViewController, UIScrollViewDelegate {

    @IBOutlet private var scrollView: UIScrollView!
    @IBOutlet private weak var comicFadeImageView: UIImageView!
    @IBOutlet private weak var comicImageCover: UIImageView!
    @IBOutlet private weak var seriesTitleLabel: UILabel!
    @IBOutlet private weak var storyTitleLabel: UILabel!

    @IBOutlet weak var volumeLabel: UILabel!
    @IBOutlet weak var issueLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var publisherLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!

    private var viewModel: ComicDetailViewModel

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    init(comicDetailViewModel: ComicDetailViewModel) {
        viewModel = comicDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
