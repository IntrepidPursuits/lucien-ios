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

    @IBOutlet private weak var volumeLabel: UILabel!
    @IBOutlet private weak var issueLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var publisherLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var conditionLabel: UILabel!

    @IBOutlet private weak var footerView: UIView!
    @IBOutlet private weak var borrowerNameLabel: UILabel!
    @IBOutlet private weak var dueDateLabel: UILabel!
    @IBOutlet private weak var returnedButton: UIButton!

    private var viewModel: ComicDetailViewModel
    let disposeBag = DisposeBag()

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpObservers()
        configureNavigationController()
        setStyling()
    }

    init(comicDetailViewModel: ComicDetailViewModel) {
        viewModel = comicDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func back(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

    @objc func presentEditForm(sender: UIBarButtonItem) {
        let comicFormViewModel = ComicFormViewModel()
        let comicFormViewController = ComicFormViewController(comicFormViewModel: comicFormViewModel)
        navigationController?.pushViewController(comicFormViewController, animated: true)
    }

    private func configureNavigationController() {
        navigationItem.title = "Details"
        navigationController?.navigationBar.setNavBarTitle()
        navigationController?.navigationBar.setNavBarBackground()
        setNavBarBackButton()
        setEditButton()
    }

    private func setNavBarBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(named: "navBackButton"), style: .plain, target: self, action: #selector(back(sender:)))
        backButton.tintColor = LucienTheme.dark
        navigationItem.leftBarButtonItem = backButton
    }

    private func setEditButton() {
        let editButton = UIBarButtonItem(image: UIImage(named: "editIcon"), style: .plain, target: self, action: #selector(presentEditForm(sender:)))
        navigationItem.rightBarButtonItem = editButton
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
        comicFadeImageView.rx.image <- viewModel.comicImage >>> disposeBag
    }

    func setStyling() {
        comicImageCover.clipsToBounds = true
        comicImageCover.layer.cornerRadius = CGFloat(6.0)
        if let image = comicFadeImageView.image {
            let blurEffectImage = image.blur(radius: 6.0)
            comicFadeImageView.image = blurEffectImage
        }
        comicFadeImageView.layer.opacity = 0.2
        comicFadeImageView.clipsToBounds = true
        comicFadeImageView.layer.cornerRadius = 6.0
        returnedButton.layer.cornerRadius = 3.0
        returnedButton.clipsToBounds = true
    }

    func roundTopCorners(flatView: UIView) {
        let rectShape = CAShapeLayer()
        rectShape.bounds = flatView.frame
        rectShape.position = flatView.center
        rectShape.path = UIBezierPath(roundedRect: flatView.bounds, byRoundingCorners: [.topRight, .topLeft], cornerRadii: CGSize(width: 12, height: 12)).cgPath
        flatView.layer.backgroundColor = UIColor.green.cgColor
        flatView.layer.mask = rectShape
    }
}
