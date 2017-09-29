//
//  AddComicViewController.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 9/26/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit
import QuartzCore

final class AddComicViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: - Constants

    private let conditions = ["Near Mint",
                             "Very Fine",
                             "Fine",
                             "Very Good",
                             "Good",
                             "Fair",
                             "Poor"
    ]

    private let genres = ["Action/Adventure",
                         "Children’s",
                         "Comedy",
                         "Crime",
                         "Drama",
                         "Fantasy",
                         "Graphic Novels",
                         "Historical",
                         "Horror",
                         "LGTBQ",
                         "Literature",
                         "Manga",
                         "Mature",
                         "Movies & TV",
                         "Music",
                         "Mystery",
                         "Non-Fiction",
                         "Original Series",
                         "Political",
                         "Post-Apocalyptic",
                         "Religious",
                         "Romance",
                         "School Life",
                         "Science Fiction",
                         "Slice of Life",
                         "Superhero",
                         "Supernatural/Occult",
                         "Suspense",
                         "Western"
    ]

    // MARK: - Private IBOutlets

    @IBOutlet private weak var coverPhotoLabel: UILabel!
    @IBOutlet private weak var coverPhotoButton: UIButton!
    @IBOutlet private weak var comicTitleLabel: UILabel!
    @IBOutlet private weak var comicTitleTextField: UITextField!
    @IBOutlet private weak var storyTitleLabel: UILabel!
    @IBOutlet private weak var storyTitleTextField: UITextField!
    @IBOutlet private weak var volumeLabel: UILabel!
    @IBOutlet private weak var volumeTextField: UITextField!
    @IBOutlet private weak var issueLabel: UILabel!
    @IBOutlet private weak var issueTextField: UITextField!
    @IBOutlet private weak var publisherLabel: UILabel!
    @IBOutlet private weak var publisherTextField: UITextField!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var conditionLabel: UILabel!
    @IBOutlet private weak var selectADateButton: UIButton!
    @IBOutlet private weak var selectAGenreButton: UIButton!
    @IBOutlet private weak var selectAConditionButton: UIButton!
    @IBOutlet private weak var datePicker: UIDatePicker!
    @IBOutlet private weak var conditionPicker: UIPickerView!
    @IBOutlet private weak var genrePicker: UIPickerView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var releaseDateBottomLine: UIView!
    @IBOutlet private weak var genreBottomLine: UIView!
    @IBOutlet private weak var conditionBottomLine: UIView!

    override func viewDidLoad() {
        super.viewDidLoad()
        configureViewController()
    }

    // MARK: - Private Instance Methods

    private func configureViewController() {
        // Cover Photo Cell
        coverPhotoLabel.font = UIFont(name: LucienTheme.Fonts.Muli.light.rawValue, size: 12)
        coverPhotoLabel.textColor = LucienTheme.coolGrey

        coverPhotoButton.titleLabel?.lineBreakMode = .byWordWrapping
        coverPhotoButton.titleLabel?.textAlignment = .center
        coverPhotoButton.setTitle("Take \n Cover \n Photo", for: .normal)
        coverPhotoButton.titleLabel?.font = UIFont(name: LucienTheme.Fonts.Muli.bold.rawValue, size: 13)
        coverPhotoButton.setTitleColor(LucienTheme.dark, for: .normal)
        coverPhotoButton.titleEdgeInsets.top = 25
        coverPhotoButton.layer.cornerRadius = 6
        coverPhotoButton.clipsToBounds = true
        coverPhotoButton.layer.borderWidth = 0.3
        coverPhotoButton.layer.borderColor = UIColor.gray.cgColor

        // Comic Title
        cconfigureLabelwith(label: comicTitleLabel, fontName: LucienTheme.Fonts.Muli.light.rawValue, size: 12, color: LucienTheme.coolGrey)
        configureTextFieldBorder(textField: comicTitleTextField)
        comicTitleTextField.attributedPlaceholder = createPlaceHolderAttributedString(textFieldPlaceholderText: "Comic Title")

        // Story Title
        cconfigureLabelwith(label: storyTitleLabel, fontName: LucienTheme.Fonts.Muli.light.rawValue, size: 12, color: LucienTheme.coolGrey)
        configureTextFieldBorder(textField: storyTitleTextField)
        storyTitleTextField.attributedPlaceholder = createPlaceHolderAttributedString(textFieldPlaceholderText: "Story Title")

        // Volume
        cconfigureLabelwith(label: volumeLabel, fontName: LucienTheme.Fonts.Muli.light.rawValue, size: 12, color: LucienTheme.coolGrey)
        configureTextFieldBorder(textField: volumeTextField)
        volumeTextField.attributedPlaceholder = createPlaceHolderAttributedString(textFieldPlaceholderText: "Volume Number")

        // Issue
        cconfigureLabelwith(label: issueLabel, fontName: LucienTheme.Fonts.Muli.light.rawValue, size: 12, color: LucienTheme.coolGrey)
        configureTextFieldBorder(textField: issueTextField)
        issueTextField.attributedPlaceholder = createPlaceHolderAttributedString(textFieldPlaceholderText: "Issue Number")

        // Publisher
        cconfigureLabelwith(label: publisherLabel, fontName: LucienTheme.Fonts.Muli.light.rawValue, size: 12, color: LucienTheme.coolGrey)
        configureTextFieldBorder(textField: publisherTextField)
        publisherTextField.attributedPlaceholder = createPlaceHolderAttributedString(textFieldPlaceholderText: "Marvel, DC Comics, Image, Dark Horse…")

        // Release Date
        cconfigureLabelwith(label: releaseDateLabel, fontName: LucienTheme.Fonts.Muli.light.rawValue, size: 12, color: LucienTheme.coolGrey)
        configureUIButton(button: selectADateButton)

        // Genre
        cconfigureLabelwith(label: genreLabel, fontName: LucienTheme.Fonts.Muli.light.rawValue, size: 12, color: LucienTheme.coolGrey)
        configureUIButton(button: selectAGenreButton)

        // Condition
        cconfigureLabelwith(label: conditionLabel, fontName: LucienTheme.Fonts.Muli.light.rawValue, size: 12, color: LucienTheme.coolGrey)
        configureUIButton(button: selectAConditionButton)
    }

    private func cconfigureLabelwith(label: UILabel, fontName: String, size: CGFloat, color: UIColor) {
        label.font = UIFont(name: fontName, size: size)
        label.textColor = color
    }

    private func configureTextFieldBorder(textField: UITextField) {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0.0, y: textField.frame.height - 3.0, width: textField.frame.width, height: 1.0)
        bottomBorder.backgroundColor = LucienTheme.silver.cgColor
        textField.borderStyle = UITextBorderStyle.none
        textField.layer.addSublayer(bottomBorder)
    }

    private func configureUIButton(button: UIButton) {
        button.setImage(UIImage(named: "dropDownArrow"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets.left = button.frame.width - 24
        button.tintColor = LucienTheme.dark
    }

    private func createPlaceHolderAttributedString(textFieldPlaceholderText: String) -> NSAttributedString {
        let placeholderAttributes = [
        NSAttributedStringKey.foregroundColor: LucienTheme.silver,
        NSAttributedStringKey.font : UIFont(name: LucienTheme.Fonts.Muli.regular.rawValue, size: 16) ?? UIFont()
        ] as [NSAttributedStringKey : Any]

       return NSAttributedString(string: textFieldPlaceholderText, attributes: placeholderAttributes)
    }

    // MARK: - IBOutlet Methods

    @IBAction func selectADateButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.datePicker.isHidden = false
        })
    }

    @IBAction func selectGenreButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.genrePicker.isHidden = false
        })
    }

    @IBAction func selectConditionButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.conditionPicker.isHidden = false
        })
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == genrePicker ? genres.count : conditions.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == genrePicker ? genres[row] : conditions[row]
    }

    // MARK: - UIPickerViewDataSource
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}
