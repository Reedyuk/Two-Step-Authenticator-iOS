//
//  KeyboardViewController.swift
//  TSAKeyboard
//
//  Created by Andrew Reed on 08/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit

class KeyboardViewController: UIInputViewController {
    private weak var _heightConstraint: NSLayoutConstraint?
    var keyboardNodeViewController: KeyboardNodeViewController?

    override func viewDidLoad() {
        super.viewDidLoad()
        Settings.sharedInstance.initalise()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard nil == _heightConstraint else { return }
        let emptyView = UILabel(frame: .zero)
        emptyView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(emptyView)
        let heightConstraint = NSLayoutConstraint(item: view,
                                                  attribute: .height,
                                                  relatedBy: .equal,
                                                  toItem: nil,
                                                  attribute: .notAnAttribute,
                                                  multiplier: 0.0,
                                                  constant: 220)
        heightConstraint.priority = .required - 1
        view.addConstraint(heightConstraint)
        _heightConstraint = heightConstraint
        loadInterface()
    }

    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }

    func loadInterface() {
        if keyboardNodeViewController == nil {
//            let keyboardNodeViewController = KeyboardNodeViewController(textDocumentProxy: textDocumentProxy,
//                                                                        parentInputViewController: self)
//            view.addSubview(keyboardNodeViewController.view)
//            self.keyboardNodeViewController = keyboardNodeViewController
//            let seperator = UIView(frame: CGRect(x: 0,
//                                                 y: 0,
//                                                 width: view.frame.width,
//                                                 height: 1))
//            seperator.backgroundColor = UIColor.lightGray
//            self.keyboardNodeViewController?.view.addSubview(seperator)
            let tokenListViewController = TokenListViewController(textDocumentProxy: textDocumentProxy,
                                                                  keyboardViewController: self)
            view.addSubview(tokenListViewController.view)
        }
    }
}
