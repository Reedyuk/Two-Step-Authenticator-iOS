//
//  UIViewController.swift
//
//
//  Created by Andrew Reed on 19/09/2017.
//  Copyright © 2017 Andrew Reed. All rights reserved.
//

import UIKit

extension UIViewController {
    func showSimpleAlert(title: String, message: String) {
        let alertView = UIAlertController(
            title: title,
            message: message,
            preferredStyle: .alert
        )
        let cancelButton = UIAlertAction(
            title: Strings.ActionButtons.okButton,
            style: .cancel,
            handler: nil
        )
        alertView.addAction(cancelButton)
        present(alertView, animated: true, completion: nil)
    }
}
