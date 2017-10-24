//
//  ComicDetailScreenViewController.swift
//  lucien-ios
//
//  Created by Fang, Gracie on 10/24/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

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
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpObservers()
    }

    init(comicDetailViewModel: ComicDetailViewModel) {
        viewModel = comicDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpObservers() {
        seriesTitleLabel.rx.text <- viewModel.comicTitle >>> disposeBag
        storyTitleLabel.rx.text <- viewModel.storyTitle >>> disposeBag
        volumeLabel.rx.text <- viewModel.volume >>> disposeBag
        issueLabel.rx.text <- viewModel.issue >>> disposeBag
        releaseDateLabel.rx.text <- viewModel.releaseDate >>> disposeBag
        publisherLabel.rx.text <- viewModel.publisher >>> disposeBag
        genreLabel.rx.text <- viewModel.genre >>> disposeBag
        conditionLabel.rx.text <- viewModel.condition >>> disposeBag
        comicImageCover.rx.image <- viewModel.comicImage >>> disposeBag
    }
}
