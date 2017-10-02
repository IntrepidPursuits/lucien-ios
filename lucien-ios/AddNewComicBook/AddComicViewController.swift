//
//  AddComicViewController.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 9/26/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit
import QuartzCore

final class AddComicViewController: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource, UITextFieldDelegate {
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
    @IBOutlet private weak var comicTitleWarningLabel: UILabel!

    // MARK: - Private Variables
    private var didCompleteForm = false
    private var finishButton = UIBarButtonItem()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        configureViewController()
    }

    // MARK: - Private Instance Methods

    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
    }

    private func configureNavigationController() {
        guard let navigationController = navigationController else {
            return
        }

        // NavigationBar Background
        navigationController.navigationBar.isTranslucent = true
        navigationController.navigationBar.barStyle = .default
        navigationController.navigationBar.barTintColor = LucienTheme.white
        navigationController.navigationBar.setValue(true, forKey: "hidesShadow")

        // NavigationBar Title
        navigationController.viewControllers[0].title = "Add Book"
        navigationController.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: LucienTheme.Fonts.PermanentMarker.regular.getFont(size: 30) ?? UIFont()]

        // NavigationBar Back Button
        let backButton = UIBarButtonItem(image: UIImage(named: "navBackButton"), style: .plain, target: self, action: #selector(AddComicViewController.backButtonTapped))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton

        // NavigationBar 'Finish' Button
        finishButton = UIBarButtonItem(title: "Finish", style: .plain, target: self, action: nil)
        finishButton.setTitleTextAttributes([NSAttributedStringKey.font: LucienTheme.Fonts.Muli.semiBold.getFont(size: 17) ?? UIFont()], for: .normal)
        finishButton.tintColor = LucienTheme.finishButtonGrey
        finishButton.isEnabled = false
        navigationItem.rightBarButtonItem = finishButton
    }

    private func configureViewController() {
        // Cover Photo Cell
        configureAddCoverUIButton(button: coverPhotoButton)

        // Comic Title
        configureTextFieldBorder(textField: comicTitleTextField)
        comicTitleTextField.attributedPlaceholder = createPlaceHolderAttributedString(textFieldPlaceholderText: "Comic Title")
        comicTitleTextField.addTarget(self, action: #selector(AddComicViewController.comicTitleEditingChanged), for: .editingChanged)

        // Story Title
        configureTextFieldBorder(textField: storyTitleTextField)
        storyTitleTextField.attributedPlaceholder = createPlaceHolderAttributedString(textFieldPlaceholderText: "Story Title")

        // Volume
        configureTextFieldBorder(textField: volumeTextField)
        volumeTextField.attributedPlaceholder = createPlaceHolderAttributedString(textFieldPlaceholderText: "Volume Number")

        // Issue
        configureTextFieldBorder(textField: issueTextField)
        issueTextField.attributedPlaceholder = createPlaceHolderAttributedString(textFieldPlaceholderText: "Issue Number")

        // Publisher
        configureTextFieldBorder(textField: publisherTextField)
        publisherTextField.attributedPlaceholder = createPlaceHolderAttributedString(textFieldPlaceholderText: "Marvel, DC Comics, Image, Dark Horse…")

        // Release Date
        configurePickerUIButton(button: selectADateButton)

        // Genre
        configurePickerUIButton(button: selectAGenreButton)

        // Condition
        configurePickerUIButton(button: selectAConditionButton)
    }

    private func configureTextFieldBorder(textField: UITextField) {
        let bottomBorder = CALayer()
        bottomBorder.frame = CGRect(x: 0.0, y: textField.frame.height - 3.0, width: textField.frame.width, height: 1.0)
        bottomBorder.backgroundColor = LucienTheme.silver.cgColor
        textField.borderStyle = UITextBorderStyle.none
        textField.layer.addSublayer(bottomBorder)
    }

    private func configurePickerUIButton(button: UIButton) {
        button.setImage(UIImage(named: "dropDownArrow"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets.left = button.frame.width - 24
        button.tintColor = LucienTheme.dark
    }

    private func configureAddCoverUIButton(button: UIButton) {
        button.titleLabel?.lineBreakMode = .byWordWrapping
        button.titleLabel?.textAlignment = .center
        button.setTitle("Take \n Cover \n Photo", for: .normal)
        button.titleLabel?.font = LucienTheme.Fonts.Muli.bold.getFont(size: 13)
        button.setTitleColor(LucienTheme.dark, for: .normal)
        button.titleEdgeInsets.top = 25
    }

    private func createPlaceHolderAttributedString(textFieldPlaceholderText: String) -> NSAttributedString {
        let placeholderAttributes = [
        NSAttributedStringKey.foregroundColor: LucienTheme.silver,
        NSAttributedStringKey.font : LucienTheme.Fonts.Muli.regular.getFont(size: 16) ?? UIFont()
        ] as [NSAttributedStringKey : Any]
       return NSAttributedString(string: textFieldPlaceholderText, attributes: placeholderAttributes)
    }

    @objc private func comicTitleEditingChanged(_ textField: UITextField) {
        guard let comicTitle = textField.text, !comicTitle.isEmpty else {
            finishButton.isEnabled = false
            finishButton.tintColor = LucienTheme.finishButtonGrey
            return
        }
        finishButton.isEnabled = true
        finishButton.tintColor = LucienTheme.dark
    }

    // MARK: - IBOutlet Methods

    @IBAction func selectADateButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.datePicker.isHidden = false
        }, completion: {_ in
            let offset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
            self.scrollView.setContentOffset(offset, animated: true)
        })
    }

    @IBAction func selectGenreButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.genrePicker.isHidden = false
        }, completion: {_ in
            let offset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
            self.scrollView.setContentOffset(offset, animated: true)
        })
    }

    @IBAction func selectConditionButtonTapped(_ sender: UIButton) {
        UIView.animate(withDuration: 0.3, animations: {
            self.conditionPicker.isHidden = false
        }, completion: {_ in
            let offset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
            self.scrollView.setContentOffset(offset, animated: true)
        })
    }

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == genrePicker ? Comic.Genre.allCases.count : Comic.Condition.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == genrePicker ? Comic.Genre(rawValue: row)?.title : Comic.Condition(rawValue: row)?.title
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }

    // MARK: - UITextFieldDelegate

    func textFieldDidBeginEditing(_ textField: UITextField) {
        let bottomBorder = textField.layer.sublayers![0] as CALayer
        bottomBorder.backgroundColor = LucienTheme.dark.cgColor

        guard let comicTitleText = comicTitleTextField.text else {
            return
        }

        if textField != comicTitleTextField && comicTitleText.isEmpty {
            comicTitleWarningLabel.isHidden = false
            let comicTitleTextFieldBottomBorder = comicTitleTextField.layer.sublayers![0] as CALayer
            comicTitleTextFieldBottomBorder.backgroundColor = LucienTheme.textFieldBottomBorderWarning.cgColor
            finishButton.isEnabled = false
            finishButton.tintColor = LucienTheme.finishButtonGrey
        } else if textField == comicTitleTextField {
            comicTitleWarningLabel.isHidden = true
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        let bottomBorder = textField.layer.sublayers![0] as CALayer
        bottomBorder.backgroundColor = LucienTheme.silver.cgColor
    }
}
