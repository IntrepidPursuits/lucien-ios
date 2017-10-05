//
//  AddComicViewController.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 9/26/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

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
    @IBOutlet private weak var selectAGenreButton: UIButton!
    @IBOutlet private weak var selectAConditionButton: UIButton!
    @IBOutlet private weak var conditionPicker: UIPickerView!
    @IBOutlet private weak var genrePicker: UIPickerView!
    @IBOutlet private weak var scrollView: UIScrollView!
    @IBOutlet private weak var genreBottomLine: UIView!
    @IBOutlet private weak var conditionBottomLine: UIView!
    @IBOutlet private weak var comicTitleWarningLabel: UILabel!
    @IBOutlet private weak var releaseDateTextField: UITextField!

    // MARK: - Private Variables

    private var didCompleteForm = false
    private var finishButton = UIBarButtonItem()
    private var activeField: UITextField?

    // MARK: - Constants
    private let cameraViewController = CameraViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavigationController()
        configureViewController()
        registerForKeyboardNotifications()
    }

    // MARK: - Private Instance Methods

    @objc private func backButtonTapped() {
        dismiss(animated: true, completion: nil)
        deregisterFromKeyboardNotifications()
    }

    private func configureNavigationController() {
        setNavBarBackground()
        setNavBarTitle()
        setNavBarBackButton()
        setNavBarFinishButton()
    }

    private func setNavBarBackground() {
        navigationController?.navigationBar.isTranslucent = true
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.barTintColor = LucienTheme.white
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
    }

    private func setNavBarTitle() {
        navigationController?.viewControllers[0].title = "Add Book"
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: LucienTheme.Fonts.permanentMarkerRegular(size: 30) ?? UIFont()]
    }

    private func setNavBarBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(named: "navBackButton"), style: .plain, target: self, action: #selector(AddComicViewController.backButtonTapped))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
    }

    private func setNavBarFinishButton() {
        finishButton = UIBarButtonItem(title: "Finish", style: .plain, target: self, action: nil)
        finishButton.setTitleTextAttributes([NSAttributedStringKey.font: LucienTheme.Fonts.muliSemiBold(size: 17) ?? UIFont()], for: .normal)
        finishButton.tintColor = LucienTheme.finishButtonGrey
        finishButton.isEnabled = false
        navigationItem.rightBarButtonItem = finishButton
    }

    private func configureViewController() {
        // Comic Title
        configureTextFieldBorder(textField: comicTitleTextField)
        comicTitleTextField.attributedPlaceholder = createPlaceHolderAttributedString(placeholder: "Comic Title")
        comicTitleTextField.addTarget(self, action: #selector(AddComicViewController.comicTitleEditingChanged), for: .editingChanged)

        // Story Title
        configureTextFieldBorder(textField: storyTitleTextField)
        storyTitleTextField.attributedPlaceholder = createPlaceHolderAttributedString(placeholder: "Story Title")

        // Volume
        configureTextFieldBorder(textField: volumeTextField)
        volumeTextField.attributedPlaceholder = createPlaceHolderAttributedString(placeholder: "Volume Number")

        // Issue
        configureTextFieldBorder(textField: issueTextField)
        issueTextField.attributedPlaceholder = createPlaceHolderAttributedString(placeholder: "Issue Number")

        // Publisher
        configureTextFieldBorder(textField: publisherTextField)
        publisherTextField.attributedPlaceholder = createPlaceHolderAttributedString(placeholder: "Marvel, DC Comics, Image, Dark Horse…")

        // Release Date
        configureTextFieldBorder(textField: releaseDateTextField)
        releaseDateTextField.attributedPlaceholder = createPlaceHolderAttributedString(placeholder: "Year of Release")
        releaseDateTextField.addTarget(self, action: #selector(AddComicViewController.releaseDateEditingChanged), for: .editingChanged)

        let releaseDateToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        releaseDateToolBar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(AddComicViewController.doneButtonTapped))
        var barButtonItems = [UIBarButtonItem]()
        barButtonItems.append(flexSpace)
        barButtonItems.append(doneButton)
        releaseDateToolBar.items = barButtonItems
        releaseDateToolBar.sizeToFit()
        releaseDateTextField.inputAccessoryView = releaseDateToolBar

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

    private func createPlaceHolderAttributedString(placeholder: String) -> NSAttributedString {
        let placeholderAttributes = [
        NSAttributedStringKey.foregroundColor: LucienTheme.silver,
        NSAttributedStringKey.font : LucienTheme.Fonts.muliRegular(size: 16) ?? UIFont()
        ] as [NSAttributedStringKey : Any]
       return NSAttributedString(string: placeholder, attributes: placeholderAttributes)
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

    @objc private func releaseDateEditingChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.characters.count > 4 {
            textField.deleteBackward()
        }
    }

    @objc func doneButtonTapped() {
        view.endEditing(true)
        deregisterFromKeyboardNotifications()
    }

    @IBAction func addCoverButtonTapped(_ sender: UIButton) {
        if AVCaptureDevice.authorizationStatus(for: AVMediaType.video) ==  AVAuthorizationStatus.authorized {
            present(cameraViewController, animated: true, completion: nil)
        } else {
            AVCaptureDevice.requestAccess(for: AVMediaType.video, completionHandler: { (granted: Bool) -> Void in
                if granted == true {
                    self.present(self.cameraViewController, animated: true, completion: nil)
                }
            })
        }
    }

    // MARK: - IBOutlet Methods

    @IBAction func selectGenreButtonTapped(_ sender: UIButton) {
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.genrePicker.isHidden = false
            },
            completion: { _ in
                let offset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
                self.scrollView.setContentOffset(offset, animated: true)
            }
        )
    }

    @IBAction func selectConditionButtonTapped(_ sender: UIButton) {
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.conditionPicker.isHidden = false
            },
            completion: { _ in
                let offset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
                self.scrollView.setContentOffset(offset, animated: true)
            }
        )
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
        activeField = textField
         guard let comicTitleText = comicTitleTextField.text,
               let bottomBorderSubLayer = textField.layer.sublayers,
               let comicTitleTextFieldSubLayers = comicTitleTextField.layer.sublayers else {
            return
        }

        let bottomBorder = bottomBorderSubLayer[0] as CALayer
        bottomBorder.backgroundColor = LucienTheme.dark.cgColor

        if textField != comicTitleTextField && comicTitleText.isEmpty {
            comicTitleWarningLabel.isHidden = false
            let comicTitleTextFieldBottomBorder = comicTitleTextFieldSubLayers[0] as CALayer
            comicTitleTextFieldBottomBorder.backgroundColor = LucienTheme.textFieldBottomBorderWarning.cgColor
            finishButton.isEnabled = false
            finishButton.tintColor = LucienTheme.finishButtonGrey
        } else if textField == comicTitleTextField {
            comicTitleWarningLabel.isHidden = true
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
        guard let textFieldSubLayers = textField.layer.sublayers else { return }
        let bottomBorder = textFieldSubLayers[0] as CALayer
        bottomBorder.backgroundColor = LucienTheme.silver.cgColor
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = textField.superview?.superview?.viewWithTag(textField.tag + 1) as? UITextField {
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }

    // MARK: - Keyboard Methods

    func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(AddComicViewController.keyboardWasShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }

    func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }

    @objc func keyboardWasShown(notification: NSNotification) {
        guard
            let info = notification.userInfo,
            let keyboardSize = (info[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue.size
            else { return }
        scrollView.isScrollEnabled = true
        let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height + LucienConstants.keyboardHeightPadding, right: 0.0)
        scrollView.contentInset = contentInsets
        scrollView.scrollIndicatorInsets = contentInsets
        var viewFrame = view.frame
        viewFrame.size.height -= keyboardSize.height
        if let activeField = activeField {
            if  !viewFrame.contains(activeField.frame.origin) {
                scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
}
