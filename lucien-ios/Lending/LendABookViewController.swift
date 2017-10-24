//
//  LendABookViewController.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/19/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class LendABookViewController: UIViewController, UITableViewDelegate, AlertDisplaying {

    // MARK: - Private IBOutlets

    @IBOutlet private weak var comicPhoto: UIImageView!
    @IBOutlet private weak var seriesTitleLabel: UILabel!
    @IBOutlet private weak var storyTitleLabel: UILabel!
    @IBOutlet private weak var volumeLabel: UILabel!
    @IBOutlet private weak var tableView: UITableView!
    @IBOutlet private weak var comicInfoView: UIView!

    // MARK: - Private Constants

    private let disposeBag = DisposeBag()
    private let viewModel = LendingBookViewModel()

    // MARK: - Private Variables

    private var nextButton = UIBarButtonItem()
    private let lendingCell = UINib(nibName: "LendingTableViewCell", bundle: nil)
    private let headerView = UIView()

    // MARK: - Variables

    var selectedIndex: Int?

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        configureTableView()

        viewModel.getAllUsers { [weak self] (users, error) in
            if error == nil {
                guard let users = users else { return }
                self?.viewModel.users.value = users
                DispatchQueue.main.async {
                    self?.tableView.reloadData()
                }
            } else {
                self?.showAlert(title: "Error", message: "Our service is currently encountering an issue. Please ensure that you are connected to the internet and try again.")
            }
        }
    }

    // MARK: - Private Instance Methods

    private func configureTableView() {
        tableView.register(lendingCell, forCellReuseIdentifier: "userCell")

        tableView.rx.itemSelected.subscribe(onNext: { [weak self] indexPath in
            self?.nextButton.isEnabled = true
            self?.nextButton.tintColor = LucienTheme.dark
            self?.selectedIndex = indexPath.row
            self?.tableView.reloadData()
        }) >>> disposeBag

        viewModel.users.asObservable().bind(to: tableView.rx.items(cellIdentifier: "userCell",
                                                                   cellType: LendingTableViewCell.self)) { [weak self] row, user, cell in

                                                                    cell.nameLabel.text = "\(user.firstName) \(user.lastName)"
                                                                    cell.emailLabel.text = user.email

                                                                    if row  == self?.selectedIndex {
                                                                        cell.accessoryType = .checkmark
                                                                        cell.accessoryView = UIImageView(image: UIImage(named: "checkmark"))
                                                                    } else {
                                                                        cell.accessoryType = .none
                                                                    }
        } >>> disposeBag
    }

    private func configureNavigationController() {
        setNavBarBackground()
        setNavBarTitle()
        setNavBarBackButton()
        setNavBarNextButton()
    }

    private func setNavBarBackground() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = LucienTheme.white
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }

    private func setNavBarTitle() {
        navigationController?.viewControllers[0].title = "Lend Book"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: LucienTheme.Fonts.permanentMarkerRegular(size: 30) ?? UIFont()]
    }

    private func setNavBarBackButton() {
        let backButton = UIBarButtonItem()
        backButton.image = UIImage(named: "navBackButton")
        backButton.style = .plain
        backButton.rx.tap.subscribeNext { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        } >>> disposeBag
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
    }

    private func setNavBarNextButton() {
        nextButton = UIBarButtonItem(title: "Next", style: .plain, target: self, action: nil)
        nextButton.setTitleTextAttributes([NSAttributedStringKey.font: LucienTheme.Fonts.muliSemiBold(size: 17) ?? UIFont()], for: .normal)
        nextButton.tintColor = LucienTheme.finishButtonGrey
        nextButton.isEnabled = false
        // TODO: Add implementation for next button
        nextButton.rx.tap.subscribeNext { [weak self] in } >>> disposeBag
        navigationItem.rightBarButtonItem = nextButton
    }

    // MARK: - UITableViewDelegate

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 68
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        headerView.backgroundColor = UIColor.white
        headerView.layer.shadowColor = UIColor.black.withAlphaComponent(0.5).cgColor
        headerView.layer.shadowOffset = CGSize(width: 0.0, height: 0.4)
        headerView.layer.shadowOpacity = 0.5
        headerView.layer.shadowRadius = 16.0
        headerView.layer.masksToBounds =  false
        headerView.isHidden = true
        return headerView
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 10
    }

    // MARK: - UIScrollViewDelegate

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y == 0 {
            headerView.isHidden = true
        } else {
            headerView.isHidden = false
        }
    }
}
