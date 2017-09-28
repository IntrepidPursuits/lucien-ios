//
//  AddComicViewController.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 9/26/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit

final class AddComicViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    // MARK: - IBOutlets

    @IBOutlet private weak var tableView: UITableView!

    // MARK: - Constants

    private let addCoverCellViewModel = AddCoverCellViewModel()
    private let comicTextFieldCellViewModel = ComicTextFieldCellViewModel()
    private let comicReleaseDateCellViewModel = ComicReleaseDateCellViewModel()
    private let coverCellNib = UINib(nibName: "AddCoverTableViewCell", bundle: nil)
    private let releaseDateFieldCellNib = UINib(nibName: "ComicReleaseDateFieldTableViewCell", bundle: nil)
    private let textFieldCellNib = UINib(nibName: "ComicTextFieldTableViewCell", bundle: nil)

    // MARK: - Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(coverCellNib, forCellReuseIdentifier: AddCoverTableViewCell.identifier)
        tableView.register(textFieldCellNib, forCellReuseIdentifier: ComicTextFieldTableViewCell.identifier)
        tableView.register(releaseDateFieldCellNib, forCellReuseIdentifier: ComicReleaseDateFieldTableViewCell.identifier)
        tableView.separatorStyle = .none
    }

    // MARK: - UITableViewDataSource

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 9
    }

    // MARK: - UITableViewDelegate

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let addCoverCell = tableView.dequeueReusableCell(withIdentifier: AddCoverTableViewCell.identifier) as? AddCoverTableViewCell,
              let comicTextFieldCell = tableView.dequeueReusableCell(withIdentifier: ComicTextFieldTableViewCell.identifier) as? ComicTextFieldTableViewCell,
              let comicReleaseDateCell = tableView.dequeueReusableCell(withIdentifier: ComicReleaseDateFieldTableViewCell.identifier) as? ComicReleaseDateFieldTableViewCell else {
            return UITableViewCell()
        }

        switch indexPath.row {
        case 0:
            addCoverCellViewModel.configure(cell: addCoverCell)
            return addCoverCell
        case 1...5, 7...8:
            comicTextFieldCell.titleLabel.text = comicTextFieldCellViewModel.getTitleForCellAt(row: indexPath.row)
            comicTextFieldCell.comicInfoTextField.attributedPlaceholder = comicTextFieldCellViewModel.getPlaceholderTextForCellAt(row: indexPath.row)
            comicTextFieldCellViewModel.configure(cell: comicTextFieldCell)
            return comicTextFieldCell
        case 6:
            comicReleaseDateCellViewModel.configure(cell: comicReleaseDateCell)
            return comicReleaseDateCell
        default:
            return UITableViewCell()
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.row {
        case 0:
            return 284
        case 6:
            return 227
        default:
            return 75
        }
    }
}
