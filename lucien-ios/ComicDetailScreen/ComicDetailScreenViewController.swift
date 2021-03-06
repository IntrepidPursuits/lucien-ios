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
    @IBOutlet private weak var lentToBorrowedFromLabel: UILabel!
    @IBOutlet private weak var ownerBorrowerNameLabel: UILabel!
    @IBOutlet private weak var dueDateLabel: UILabel!
    @IBOutlet private weak var returnedButton: UIButton!
    @IBOutlet weak var lendBookButton: UIButton!

    private var viewModel: ComicDetailViewModel
    let disposeBag = DisposeBag()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setUpObservers()
        configureNavigationController()
        hideLendFooter()
        setUpFooter()
        setStyling()
    }

    init(comicDetailViewModel: ComicDetailViewModel) {
        viewModel = comicDetailViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setUpFooter() {
        if viewModel.userType == .borrower {
            showLendFooter()
        } else if viewModel.userType == .owner {
            showBorrowFooter()
        } else if viewModel.userType == .none {
            lendBookButton.isHidden = false
        }
    }

    func hideLendFooter() {
        lentToBorrowedFromLabel.isHidden = true
        ownerBorrowerNameLabel.isHidden = true
        dueDateLabel.isHidden = true
        returnedButton.isHidden = true
        lendBookButton.isHidden = true
    }

    func showLendFooter() {
        lentToBorrowedFromLabel.isHidden = false
        lentToBorrowedFromLabel.text = "LENT TO"
        ownerBorrowerNameLabel.isHidden = false
        dueDateLabel.isHidden = false
        returnedButton.isHidden = false
    }

    func showBorrowFooter() {
        lentToBorrowedFromLabel.isHidden = false
        lentToBorrowedFromLabel.text = "BORROWED FROM"
        ownerBorrowerNameLabel.isHidden = false
        dueDateLabel.isHidden = false
    }

    @objc func back(sender: UIBarButtonItem) {
        navigationController?.popViewController(animated: true)
    }

    @IBAction func lendBookButtonTapped(_ sender: UIButton) {
        let lendbookViewController = LendABookViewController(comicDetailViewModel: viewModel)
        navigationController?.pushViewController(lendbookViewController, animated: true)
    }

    @objc func presentEditForm(sender: UIBarButtonItem) {
        let optionalComicFields = OptionalComicFields(volume: viewModel.volume.value,
                                                      issueNumber: viewModel.issue.value,
                                                      publisher: viewModel.publisher.value,
                                                      releaseYear: viewModel.releaseDate.value,
                                                      comicPhotoURL: nil)
        let comic = AddEditComic(comicID: viewModel.comicID.value,
                                 comicTitle: viewModel.comicTitle.value,
                                 storyTitle: viewModel.storyTitle.value,
                                 optionalComicFields: optionalComicFields,
                                 returnDate: nil,
                                 condition: viewModel.condition.value,
                                 genre: viewModel.genre.value)
        let comicFormViewModel = ComicFormViewModel(comic: comic, coverPhoto: viewModel.comicImage.value)
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

        ownerBorrowerNameLabel.rx.text <- viewModel.ownerBorrowerName >>> disposeBag
        dueDateLabel.rx.text <- viewModel.dueDate >>> disposeBag
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
        lendBookButton.layer.cornerRadius = 3.0
        lendBookButton.clipsToBounds = true
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
