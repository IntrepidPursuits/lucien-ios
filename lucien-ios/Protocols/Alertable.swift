//
//  Alertable.swift
//  lucien-ios
//
//  Created by Ahmed, Guled on 10/9/17.
//  Copyright © 2017 Intrepid Pursuits. All rights reserved.
//

import Foundation

protocol Alertable {}
extension Alertable where Self: UIViewController {
    /// Displays an alert with only one button displaying the word "Ok" along with your desired title and message."
    func showAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .cancel, handler: { [weak self] _ in
            self?.dismiss(animated: true, completion: nil)
        })
        alertController.addAction(okAction)
        self.present(alertController, animated: true, completion: nil)
    }
}
