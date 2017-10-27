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
import RxSwift
import RxCocoa

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
    private var viewModel: ComicFormViewModel

    // MARK: - Constants

    private let cameraViewController = CameraViewController()
    private let lucienAPIClient = LucienAPIClient()
    private let disposeBag = DisposeBag()

    init(comicFormViewModel: ComicFormViewModel) {
        viewModel = comicFormViewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        viewModel = ComicFormViewModel()
        super.init(coder: aDecoder)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        cameraViewController.delegate = self
        configureNavigationController()
        configureViewController()
        registerForKeyboardNotifications()
        comicFormViewControllerTextFields = [seriesTitleTextField, volumeTextField, storyTitleTextField, issueTextField, publisherTextField, releaseDateTextField]
        configureObservables()
        configureEditForm()
    }

    // MARK: - Private Instance Methods

    private func addActivityIndicator() {
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityIndicator .frame = CGRect(x: 0, y: 0, width: 100, height: 100)
        let scale = CGAffineTransform(scaleX: 1.5, y: 1.5)
        activityIndicator.transform = scale
        activityIndicator.center = view.center
        activityIndicator.startAnimating()
        view.addSubview(activityIndicator)
    }

    private func configureEditForm() {
        if viewModel.comicFormMode == .edit {
            if let coverPhoto = viewModel.coverPhoto {
                updateCoverPhotoButton(image: coverPhoto)
            }
            checkIfAllRequiredFieldsAreFilled()
        }
    }

    private func configureObservables() {
        configureUITextFieldObservables()
        configureUIPickerViewObservables()
    }

    private func configureUITextFieldObservables() {
        seriesTitleTextField.rx.text.orEmpty <-> viewModel.seriesTitle >>> disposeBag
        volumeTextField.rx.text <-> viewModel.volume >>> disposeBag
        storyTitleTextField.rx.text.orEmpty <->  viewModel.storyTitle >>> disposeBag
        issueTextField.rx.text <->  viewModel.issue >>> disposeBag
        publisherTextField.rx.text <->  viewModel.publisher >>> disposeBag
        releaseDateTextField.rx.text <-> viewModel.release >>> disposeBag

        seriesTitleTextField.rx.controlEvent([.editingChanged]).asObservable().subscribeNext { [weak self] in
            self?.seriesTitleWarningLabel.isHidden = true
            self?.seriesTitleTextField.borderColor = LucienTheme.dark
            self?.checkIfAllRequiredFieldsAreFilled()
        } >>> disposeBag

        storyTitleTextField.rx.controlEvent([.editingChanged]).asObservable().subscribeNext { [weak self] in
            self?.storyTitleWarningLabel.isHidden = true
            self?.storyTitleTextField.borderColor = LucienTheme.dark
            self?.checkIfAllRequiredFieldsAreFilled()
        } >>> disposeBag

        releaseDateTextField.rx.controlEvent([.editingChanged]).asObservable().subscribeNext { [weak self] in
            guard let text = self?.releaseDateTextField.text else { return }
            if text.characters.count > LucienConstants.releaseDateTextFieldCharacterCountLimit {
                self?.releaseDateTextField.deleteBackward()
            }
        } >>> disposeBag
    }

    private func configureUIPickerViewObservables() {
        viewModel.genreTitles.bind(to: genrePicker.rx.itemTitles) { _, title in return title } >>> disposeBag
        viewModel.conditionTitles.bind(to: conditionPicker.rx.itemTitles) { _, title in return title } >>> disposeBag

        genrePicker.rx.itemSelected.subscribeNext { [weak self] row, _ in
            let selectedGenre = Genre(rawValue: row)
            self?.viewModel.genre.value = selectedGenre
            self?.selectAGenreButton.setTitle(selectedGenre?.title, for: .normal)
            self?.setArrowImageEdgeInsets(button: self?.selectAGenreButton)
            } >>> disposeBag

        conditionPicker.rx.itemSelected.subscribeNext { [weak self] row, _ in
            let selectedCondition = Condition(rawValue: row)
            self?.viewModel.condition.value = selectedCondition
            self?.selectAConditionButton.setTitle(selectedCondition?.title, for: .normal)
            self?.setArrowImageEdgeInsets(button: self?.selectAConditionButton)
        } >>> disposeBag

        viewModel.genre.asObservable().subscribe(onNext: { [weak self] genre in
            if let genre = genre {
                self?.genrePicker.isHidden = false
                self?.genrePicker.selectRow(genre.rawValue, inComponent: 0, animated: false)
                self?.selectAGenreButton.setTitle(genre.title, for: .normal)
            }
        }) >>> disposeBag

        viewModel.condition.asObservable().subscribe(onNext: { [weak self] condition in
            if let condition = condition {
                self?.conditionPicker.isHidden = false
                self?.conditionPicker.selectRow(condition.rawValue, inComponent: 0, animated: false)
                self?.selectAConditionButton.setTitle(condition.title, for: .normal)
            }
        }) >>> disposeBag
    }

    private func setArrowImageEdgeInsets(button: UIButton?) {
        guard let button = button else { return }
        button.imageEdgeInsets.left = 300
    }

    private func configureNavigationController() {
        navigationController?.navigationBar.setNavBarBackground()
        navigationItem.title = viewModel.navigationBarTitle
        navigationController?.navigationBar.setNavBarTitle()
        setNavBarBackButton()
        setNavBarFinishButton()
    }

    private func setNavBarBackButton() {
        let backButton = UIBarButtonItem()
        backButton.image = UIImage(named: "navBackButton")
        backButton.style = .plain
        backButton.rx.tap.subscribeNext { [weak self] in
            let goBackAction = UIAlertAction(title: "Go Back to Previous Page", style: .destructive) { _ in
                self?.navigationController?.popViewController(animated: true)
                self?.deregisterFromKeyboardNotifications()
            }
            let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
            self?.showAlert(title: "", message: "This will delete your current comic information.", actions: [goBackAction, cancelAction], preferredStyle: .actionSheet)
        } >>> disposeBag
        backButton.tintColor = UIColor.black
        navigationItem.leftBarButtonItem = backButton
    }

    private func setNavBarFinishButton() {
        finishButton = UIBarButtonItem(title: "Finish", style: .plain, target: self, action: nil)
        finishButton.setTitleTextAttributes([NSAttributedStringKey.font: LucienTheme.Fonts.muliSemiBold(size: 17) ?? UIFont()], for: .normal)
        finishButton.tintColor = LucienTheme.finishButtonGrey
        finishButton.isEnabled = false
        finishButton.rx.tap.subscribeNext { [weak self] in
            self?.addActivityIndicator()
            self?.dismissKeyboardAndNotifications()
            self?.viewModel.finishButtonTapped { error in
                if error != nil {
                    self?.showAlert(title: "Error", message: "Our service is currently encountering an issue. Please ensure that you are connected to the internet and try again.")
                } else {
                    self?.goToDashboard()
                }
            }
        } >>> disposeBag
        navigationItem.rightBarButtonItem = finishButton
    }

    private func configureViewController() {
        configureReleaseDateTextFieldToolBar()
        configurePickerUIButton(button: selectAGenreButton)
        configurePickerUIButton(button: selectAConditionButton)
    }

    private func configureReleaseDateTextFieldToolBar() {
        let releaseDateToolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 50))
        releaseDateToolBar.barStyle = UIBarStyle.default
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem()
        doneButton.title = "Done"
        doneButton.style = .done
        doneButton.rx.tap.subscribeNext { [weak self] in
            guard let releaseYearIsValid = self?.checkReleaseYear() else { return }
            if releaseYearIsValid {
                self?.dismissKeyboardAndNotifications()
            } else {
                 self?.showAlertWithNoDismissal(title: "Invalid Input", message: "The release year must be less than 2200.")
            }
        } >>> disposeBag
        var barButtonItems = [UIBarButtonItem]()
        barButtonItems.append(flexSpace)
        barButtonItems.append(doneButton)
        releaseDateToolBar.items = barButtonItems
        releaseDateToolBar.sizeToFit()
        releaseDateTextField.inputAccessoryView = releaseDateToolBar
    }

    private func checkReleaseYear() -> Bool {
        guard
            let releaseYearText = releaseDateTextField.text,
            let releaseYear = Int(releaseYearText)
            else { return false }
        if releaseYear < LucienConstants.releaseYearLimit {
            return true
        } else {
            releaseDateTextField.text = ""
            return false
        }
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

    private func flipDropDownArrowImage(pickerView: UIPickerView) -> UIImage? {
        let arrowImage = UIImage(named: "dropDownArrow")
        let orientation = pickerView.isHidden ? UIImageOrientation.downMirrored : UIImageOrientation.upMirrored
        if let arrowCGImage = arrowImage?.cgImage, let scale = arrowImage?.scale {
            let flippedImage = UIImage(cgImage: arrowCGImage, scale: scale, orientation: orientation)
            return flippedImage
        }
        return nil
    }

    private func updateCoverPhotoButton(image: UIImage) {
        viewModel.coverPhoto = image
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

    private func showWarningLabel(label: UILabel, textField: UITextField) {
        guard let bottomBorderTextField = textField as? BottomBorderTextField else { return }
        label.isHidden = false
        bottomBorderTextField.borderColor = LucienTheme.textFieldBottomBorderWarning
        finishButton.isEnabled = false
        finishButton.tintColor = LucienTheme.finishButtonGrey
    }

    private func goToDashboard() {
        let alertController = UIAlertController(title: "Error",
                                                message: "Our service is currently encountering an issue. Please ensure that you are connected to the internet and try again.",
                                                preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { _ in }
        alertController.addAction(okAction)
        var dashboardComics = [DashboardComicUser]()
        lucienAPIClient.getMyComics { response in
            switch response {
            case .success(let result):
                DispatchQueue.main.async {
                    dashboardComics = result
                    self.lucienAPIClient.getDashboard { response in
                        switch response {
                        case .success(let result):
                            let viewModel = DashboardViewModel(dashboard: result, myComics: dashboardComics)
                            let dashboardViewController = DashboardViewController(dashboardViewModel: viewModel)
                            let dashboardNavigationController = UINavigationController(rootViewController: dashboardViewController)
                            self.present(dashboardNavigationController, animated: true, completion: nil)
                        case .failure:
                            self.present(alertController, animated: true, completion: nil)
                        }
                    }
                }
            case .failure:
                self.present(alertController, animated: true, completion: nil)
            }
        }
    }

    private func dismissKeyboardAndNotifications() {
        view.endEditing(true)
        deregisterFromKeyboardNotifications()
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
                if let flippedImage = self.flipDropDownArrowImage(pickerView: self.genrePicker) {
                    self.selectAGenreButton.setImage(flippedImage, for: .normal)
                }
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
                if let flippedImage = self.flipDropDownArrowImage(pickerView: self.conditionPicker) {
                    self.selectAConditionButton.setImage(flippedImage, for: .normal)
                }
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
        return pickerView == genrePicker ? Genre.allCases.count : Condition.allCases.count
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
        coverPhotoButton.alpha = LucienConstants.coverPhotoDefaultAlpha
        coverPhotoButton.isUserInteractionEnabled = true
        coverPhotoButton.setBackgroundImage(nil, for: .normal)
        coverPhotoButton.backgroundColor = LucienTheme.dark
        coverPhotoButton.layer.shadowOpacity = LucienConstants.coverPhotoDefaultShadowOpacity
        coverPhotoButton.layer.shadowRadius = LucienConstants.coverPhotoDefaultShadowRadius
        coverPhotoButton.setImage(UIImage(named: "cameraButtonIcon"), for: .normal)
        coverPhotoButton.imageEdgeInsets.bottom = LucienConstants.coverPhotoBottomImageInset
        let coverPhotoButtonTitleNormal = LucienConstants.coverPhotoNormalStateTitle
        let coverPhotoButtonTitleHighlighted = LucienConstants.coverPhotoHighlightedStateTitle
        coverPhotoButton.setAttributedTitle(coverPhotoButtonTitleNormal, for: .normal)
        coverPhotoButton.setAttributedTitle(coverPhotoButtonTitleHighlighted, for: .highlighted)
        coverPhotoButton.titleEdgeInsets.top = LucienConstants.coverPhotoTopTitleEdgeInset
        coverPhotoButton.titleLabel?.textAlignment = .center
        coverPhotoButton.titleLabel?.lineBreakMode = .byWordWrapping
    }
}
