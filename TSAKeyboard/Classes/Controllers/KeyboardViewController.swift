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

    override func viewDidLoad() {
        super.viewDidLoad()
        loadInterface()
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
                                                  constant: 200)
        heightConstraint.priority = .required - 1
        view.addConstraint(heightConstraint)
        _heightConstraint = heightConstraint
    }

    override func textWillChange(_ textInput: UITextInput?) {
        // The app is about to change the document's contents. Perform any preparation here.
    }

    override func textDidChange(_ textInput: UITextInput?) {
        // The app has just changed the document's contents, the document context has been updated.
    }

    func loadInterface() {
        let keyboardNodeViewController = KeyboardNodeViewController(textDocumentProxy: textDocumentProxy,
                                                                    parentInputViewController: self)
        present(keyboardNodeViewController, animated: true, completion: nil)
    }
}
