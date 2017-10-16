//
//  ComicFormViewController.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 9/26/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import UIKit
import QuartzCore
import AVFoundation

final class ComicFormViewController: UIViewController, AlertDisplaying {

    // MARK: - Private IBOutlets

    @IBOutlet private weak var coverPhotoLabel: UILabel!
    @IBOutlet private weak var coverPhotoButton: UIButton!
    @IBOutlet private weak var seriesTitleLabel: UILabel!
    @IBOutlet private weak var seriesTitleTextField: BottomBorderTextField!
    @IBOutlet private weak var storyTitleLabel: UILabel!
    @IBOutlet weak var storyTitleTextField: BottomBorderTextField!
    @IBOutlet weak var volumeTextField: BottomBorderTextField!
    @IBOutlet private weak var volumeLabel: UILabel!
    @IBOutlet weak var issueTextField: BottomBorderTextField!
    @IBOutlet private weak var issueLabel: UILabel!
    @IBOutlet weak var publisherTextField: BottomBorderTextField!
    @IBOutlet private weak var publisherLabel: UILabel!
    @IBOutlet weak var releaseDateTextField: BottomBorderTextField!
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
    @IBOutlet private weak var seriesTitleWarningLabel: UILabel!
    @IBOutlet private weak var storyTitleWarningLabel: UILabel!
    @IBOutlet private weak var deletePhotoButton: UIButton!
    @IBOutlet private weak var retakePhotoButton: UIButton!
    @IBOutlet private weak var coverPhotoDividerView: UIView!

    // MARK: - Private Variables

    private var finishButton = UIBarButtonItem()
    private var activeField: UITextField?
    private var comicFormViewControllerTextFields: [UITextField]?
    private var overlayButton = UIButton()
    private var currentImage: UIImage?

    // MARK: - Constants

    private let cameraViewController = CameraViewController()
    private let comicFormViewModel: ComicFormViewModel?
    private let loginViewModel = LoginViewModel()

    init(viewModel: ComicFormViewModel) {
        comicFormViewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        comicFormViewModel = ComicFormViewModel()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraViewController.delegate = self
        configureNavigationController()
        configureViewController()
        registerForKeyboardNotifications()
        comicFormViewControllerTextFields = [seriesTitleTextField, volumeTextField, storyTitleTextField, issueTextField, publisherTextField, releaseDateTextField]
        fillFieldsWithComicFormViewModelData()
    }

    // MARK: - Private Instance Methods

    @objc internal func backButtonTapped() {
        let goBackAction = UIAlertAction(title: "Go Back to Previous Page", style: .destructive) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
            self?.deregisterFromKeyboardNotifications()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        showAlert(title: "", message: "This will delete your current comic information.", actions: [goBackAction, cancelAction], preferredStyle: .actionSheet)
    }

    private func fillFieldsWithComicFormViewModelData() {
        guard let comicFormViewModel = comicFormViewModel else { return }
        if comicFormViewModel.comicFormMode == .edit {
            seriesTitleTextField.text = comicFormViewModel.seriesTitle ?? ""
            volumeTextField.text = comicFormViewModel.volume ?? ""
            storyTitleTextField.text = comicFormViewModel.storyTitle
            issueTextField.text = comicFormViewModel.issue ?? ""
            publisherTextField.text = comicFormViewModel.publisher ?? ""
            releaseDateTextField.text = comicFormViewModel.release ?? ""
            genrePicker.isHidden = false
            conditionPicker.isHidden = false
            selectAGenreButton.setTitle(comicFormViewModel.genre?.title, for: .normal)
            selectAConditionButton.setTitle(comicFormViewModel.condition?.title, for: .normal)
            genrePicker.selectRow(comicFormViewModel.genre?.rawValue ?? 0, inComponent: 0, animated: false)
            conditionPicker.selectRow(comicFormViewModel.condition?.rawValue ?? 0, inComponent: 0, animated: false)
            if let coverPhoto = comicFormViewModel.coverPhoto {
                updateCoverPhotoButton(image: coverPhoto)
            }
        }
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
        navigationController?.viewControllers[0].title = comicFormViewModel?.navigationBarTitle
        navigationController?.navigationBar.titleTextAttributes = [NSAttributedStringKey.font: LucienTheme.Fonts.permanentMarkerRegular(size: 30) ?? UIFont()]
    }

    private func setNavBarBackButton() {
        let backButton = UIBarButtonItem(image: UIImage(named: "navBackButton"), style: .plain, target: self, action: #selector(ComicFormViewController.backButtonTapped))
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
    }

    private func setNavBarFinishButton() {
        finishButton = UIBarButtonItem(title: "Finish", style: .plain, target: self, action: nil)
        finishButton.setTitleTextAttributes([NSAttributedStringKey.font: LucienTheme.Fonts.muliSemiBold(size: 17) ?? UIFont()], for: .normal)
        finishButton.tintColor = LucienTheme.finishButtonGrey
        finishButton.isEnabled = false
        finishButton.target = self
        finishButton.action = #selector(ComicFormViewController.finishButtonTapped)
        navigationItem.rightBarButtonItem = finishButton
    }

    @objc private func finishButtonTapped() {
        var publicURL = ""
        if let coverPhoto = currentImage {
            loginViewModel.createPhotoURL(image: coverPhoto, completion: { publicURLResponse in
                print(publicURLResponse)
                publicURL = publicURLResponse
            })
        }

        loginViewModel.addComicBook(comicTitle: "Test Comic Title", storyTitle: "Test Story Title", volume: "Test Volume", issueNumber: "Test Issue", publisher: "Test Publisher", releaseYear: "Test Release Year", comicPhotoURL: publicURL, returnDate: nil, condition: "good", genre: "fantasy") { (_) in
            print("DONE DONE")
        }
    }

    private func configureViewController() {
        storyTitleTextField.addTarget(self, action: #selector(ComicFormViewController.storyTitleEditingChanged), for: .editingChanged)
        releaseDateTextField.addTarget(self, action: #selector(ComicFormViewController.releaseDateEditingChanged), for: .editingChanged)
        seriesTitleTextField.addTarget(self, action: #selector(ComicFormViewController.seriesTitleEditingChanged), for: .editingChanged)
        configureReleaseDateTextFieldToolBar()
        configurePickerUIButton(button: selectAGenreButton)
        configurePickerUIButton(button: selectAConditionButton)
    }

    private func configureReleaseDateTextFieldToolBar() {
        let releaseDateToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        releaseDateToolBar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.done, target: self, action: #selector(ComicFormViewController.doneButtonTapped))
        var barButtonItems = [UIBarButtonItem]()
        barButtonItems.append(flexSpace)
        barButtonItems.append(doneButton)
        releaseDateToolBar.items = barButtonItems
        releaseDateToolBar.sizeToFit()
        releaseDateTextField.inputAccessoryView = releaseDateToolBar
    }

    private func configurePickerUIButton(button: UIButton) {
        button.setImage(UIImage(named: "dropDownArrow"), for: .normal)
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets.left = seriesTitleTextField.frame.width - LucienConstants.pickerViewLeftimageEdgeInsetOffset
        button.tintColor = LucienTheme.dark
    }

    private func checkIfAllRequiredFieldsAreFilled() {
        guard
            let seriesTitle = seriesTitleTextField.text,
            let storyTitle = storyTitleTextField.text,
            !seriesTitle.isEmpty,
            !storyTitle.isEmpty
            else {
                finishButton.isEnabled = false
                finishButton.tintColor = LucienTheme.finishButtonGrey
                return
        }
        finishButton.isEnabled = true
        finishButton.tintColor = LucienTheme.dark
    }

    private func updateCoverPhotoButton(image: UIImage) {
        showCoverPhotoMenu()
        resetCoverPhotoButton()

        let resizedImage = image.resize(size: CGSize(width: coverPhotoButton.frame.width, height: coverPhotoButton.frame.height))
        let blurredImage = image.blur(radius: LucienConstants.coverButtonBlurRadius)?.resize(size: CGSize(width: coverPhotoButton.frame.width, height: coverPhotoButton.frame.height))

        coverPhotoButton.setImage(nil, for: .normal)
        coverPhotoButton.backgroundColor = nil
        coverPhotoButton.setBackgroundImage(blurredImage, for: .normal)
        coverPhotoButton.isUserInteractionEnabled = false
        coverPhotoButton.transform = CGAffineTransform(scaleX: LucienConstants.coverButtonScaleX, y: LucienConstants.coverButtonScaleY)
        coverPhotoButton.alpha = LucienConstants.coverButtonOpacity
        coverPhotoButton.setAttributedTitle(NSAttributedString(string: ""), for: .normal)
        coverPhotoButton.layer.shadowColor = UIColor.black.cgColor
        coverPhotoButton.layer.shadowRadius = LucienConstants.coverButtonShadowRadius
        coverPhotoButton.layer.shadowOpacity = LucienConstants.coverButtonShadowOpacity

        overlayButton = UIButton(frame: coverPhotoButton.frame)
        overlayButton.transform = CGAffineTransform(scaleX: LucienConstants.overlayButtonScaleX, y: LucienConstants.overlayButtonScaleY)
        overlayButton.setBackgroundImage(resizedImage, for: .normal)
        overlayButton.isUserInteractionEnabled = false
        overlayButton.layer.masksToBounds = true
        overlayButton.layer.cornerRadius = LucienConstants.buttonBorderRadius
        overlayButton.translatesAutoresizingMaskIntoConstraints = false

        scrollView.addSubview(overlayButton)

        view.addConstraints([
            NSLayoutConstraint(item: overlayButton, attribute: .leading, relatedBy: .equal, toItem: scrollView, attribute: .leading, multiplier: 1, constant: LucienConstants.overlayButtonLeadingConstraint),
            NSLayoutConstraint(item: overlayButton, attribute: .top, relatedBy: .equal, toItem: coverPhotoLabel, attribute: .top, multiplier: 1, constant: LucienConstants.overlayButtonTopConstraint)
            ])
    }

    @objc private func seriesTitleEditingChanged(_ textField: UITextField) {
        seriesTitleWarningLabel.isHidden = true
        seriesTitleTextField.borderColor = LucienTheme.dark
        checkIfAllRequiredFieldsAreFilled()
    }

    @objc private func storyTitleEditingChanged(_ textField: UITextField) {
        storyTitleWarningLabel.isHidden = true
        storyTitleTextField.borderColor = LucienTheme.dark
        checkIfAllRequiredFieldsAreFilled()
    }

    @objc private func releaseDateEditingChanged(_ textField: UITextField) {
        guard let text = textField.text else { return }
        if text.characters.count > 4 {
            textField.deleteBackward()
        }
    }

    @objc private func doneButtonTapped() {
        view.endEditing(true)
        deregisterFromKeyboardNotifications()
    }

    private func showWarningLabel(label: UILabel, textField: UITextField) {
        guard let bottomBorderTextField = textField as? BottomBorderTextField else { return }
        label.isHidden = false
        bottomBorderTextField.borderColor = LucienTheme.textFieldBottomBorderWarning
        finishButton.isEnabled = false
        finishButton.tintColor = LucienTheme.finishButtonGrey
    }

    // MARK: - IBOutlet Methods

    @IBAction private func addCoverButtonTapped(_ sender: UIButton) {
        if AVCaptureDevice.authorizationStatus(for: .video) ==  .authorized {
            present(cameraViewController, animated: true, completion: nil)
        } else {
            AVCaptureDevice.requestAccess(for: .video) { granted in
                if granted {
                    DispatchQueue.main.async {
                        self.present(self.cameraViewController, animated: true, completion: nil)
                    }
                }
            }
        }
    }

    @IBAction private func selectGenreButtonTapped(_ sender: UIButton) {
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.genrePicker.isHidden = self.genrePicker.isHidden ? false : true
            },
            completion: { _ in
                let offset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
                self.scrollView.setContentOffset(offset, animated: true)
            }
        )
    }

    @IBAction private func selectConditionButtonTapped(_ sender: UIButton) {
        UIView.animate(
            withDuration: 0.3,
            animations: {
                self.conditionPicker.isHidden = self.conditionPicker.isHidden ? false : true
            },
            completion: { _ in
                let offset = CGPoint(x: 0, y: self.scrollView.contentSize.height - self.scrollView.bounds.size.height)
                self.scrollView.setContentOffset(offset, animated: true)
            }
        )
    }

    @IBAction private func retakeButtonTapped(_ sender: UIButton) {
        present(cameraViewController, animated: true, completion: nil)
    }

    @IBAction private func deleteCoverPhoto(_ sender: UIButton) {
        let deleteAction = UIAlertAction(title: "Delete Comic Book Photo", style: .destructive) { [weak self] _ in
            self?.resetCoverPhotoButton()
            self?.hideCoverPhotoMenu()
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        showAlert(title: "", message: "This will delete your current comic book photo.", actions: [deleteAction, cancelAction], preferredStyle: .actionSheet)
    }

    // MARK: - Keyboard Methods

    private func registerForKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(ComicFormViewController.keyboardWasShown), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }

    private func deregisterFromKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }

    @objc private func keyboardWasShown(notification: NSNotification) {
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
            if !viewFrame.contains(activeField.frame.origin) {
                scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
        scrollView.contentInset.top = 40
    }
}

extension ComicFormViewController: UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: - UIPickerViewDelegate

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerView == genrePicker ? Comic.Genre.allCases.count : Comic.Condition.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickerView == genrePicker ? Comic.Genre(rawValue: row)?.title : Comic.Condition(rawValue: row)?.title
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        switch pickerView {
        case genrePicker:
            let selectedGenre = Comic.Genre(rawValue: row)?.title
            selectAGenreButton.setTitle(selectedGenre, for: .normal)
        case conditionPicker:
            let selectedCondition = Comic.Condition(rawValue: row)?.title
            selectAConditionButton.setTitle(selectedCondition, for: .normal)
        default:
            return
        }
    }

    // MARK: - UIPickerViewDataSource

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
}

extension ComicFormViewController: UITextFieldDelegate {

    // MARK: - UITextFieldDelegate

    func textFieldDidBeginEditing(_ textField: UITextField) {
        activeField = textField
        guard
            let bottomBorderTextField = textField as? BottomBorderTextField,
            let seriesTitleText = seriesTitleTextField.text,
            let storyTitleText = storyTitleTextField.text
            else { return }

        bottomBorderTextField.borderColor = LucienTheme.dark

        if textField != seriesTitleTextField {
            if seriesTitleText.isEmpty {
                showWarningLabel(label: seriesTitleWarningLabel, textField: seriesTitleTextField)
            }
            if storyTitleText.isEmpty {
                showWarningLabel(label: storyTitleWarningLabel, textField: storyTitleTextField)
            }
        }
    }

    func textFieldDidEndEditing(_ textField: UITextField) {
        activeField = nil
        guard let bottomBorderTextField = textField as? BottomBorderTextField else { return }
        bottomBorderTextField.borderColor = LucienTheme.silver
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        guard
            let textFields = comicFormViewControllerTextFields,
            let currentTextFieldArrayIndex = textFields.index(of: textField)
            else { return false }
        let currentTextFieldIndex = textFields.startIndex.distance(to: currentTextFieldArrayIndex)
        if currentTextFieldIndex < textFields.count - 1 {
            let nextTextField = textFields[currentTextFieldIndex + 1]
            nextTextField.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return false
    }
}

extension ComicFormViewController: CameraViewControllerDelegate {

    // MARK: - CameraViewControllerDelegate

    func cameraViewController(didCapture image: UIImage) {
        updateCoverPhotoButton(image: image)
    }

    private func showCoverPhotoMenu() {
        retakePhotoButton.isHidden = false
        deletePhotoButton.isHidden = false
        coverPhotoDividerView.isHidden = false
    }

    private func hideCoverPhotoMenu() {
        retakePhotoButton.isHidden = true
        deletePhotoButton.isHidden = true
        coverPhotoDividerView.isHidden = true
    }

    private func resetCoverPhotoButton() {
        coverPhotoButton.transform = .identity
        overlayButton.removeFromSuperview()
        coverPhotoButton.alpha = 1.0
        coverPhotoButton.isUserInteractionEnabled = true
        coverPhotoButton.setBackgroundImage(nil, for: .normal)
        coverPhotoButton.backgroundColor = LucienTheme.dark
        coverPhotoButton.layer.shadowOpacity = 0.0
        coverPhotoButton.layer.shadowRadius = 0.0
        coverPhotoButton.setImage(UIImage(named: "cameraButtonIcon"), for: .normal)
        coverPhotoButton.imageEdgeInsets.bottom = 70
        let coverPhotoButtonTitleNormal = NSAttributedString(string: "Take Cover Photo", attributes: [NSAttributedStringKey.font: LucienTheme.Fonts.muliBold(size: 16.0) ?? UIFont(), NSAttributedStringKey.foregroundColor: UIColor.white])
        let coverPhotoButtonTitleHighlighted = NSAttributedString(string: "Take Cover Photo", attributes: [NSAttributedStringKey.font: LucienTheme.Fonts.muliBold(size: 16.0) ?? UIFont(), NSAttributedStringKey.foregroundColor: UIColor.white.withAlphaComponent(0.5)])
        coverPhotoButton.setAttributedTitle(coverPhotoButtonTitleNormal, for: .normal)
        coverPhotoButton.setAttributedTitle(coverPhotoButtonTitleHighlighted, for: .highlighted)
        coverPhotoButton.titleEdgeInsets = UIEdgeInsets(top: 25, left: 0, bottom: 0, right: 40)
        coverPhotoButton.titleLabel?.textAlignment = .center
        coverPhotoButton.titleLabel?.lineBreakMode = .byWordWrapping
    }
}
