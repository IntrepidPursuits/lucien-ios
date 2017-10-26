//
//  Alertable.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/9/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

protocol AlertDisplaying {}
extension AlertDisplaying where Self: UIViewController {
    /// Displays an alert with only one button displaying the word "Ok" along with your desired title and message. This alert does not dismiss the view controller."
    func showAlertWithNoDismissal(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { _ in}
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    /// Displays an alert with only one button displaying the word "Ok" along with your desired title and message."
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel) { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        }
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: nil)
    }
    /// Displays an alert that includes actions that are provided via the actions array.
    func showAlert(title: String, message: String, actions: [UIAlertAction], preferredStyle: UIAlertControllerStyle) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        for action in actions {
            alertController.addAction(action)
        }
        present(alertController, animated: true, completion: nil)
    }
}
