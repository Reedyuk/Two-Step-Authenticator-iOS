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
    var tokenListViewController: TokenListViewController?

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
                                                  constant: 180)
        heightConstraint.priority = .required - 1
        view.addConstraint(heightConstraint)
        _heightConstraint = heightConstraint
        loadInterface()
    }

    func loadInterface() {
        if tokenListViewController == nil {
            let tokenListViewController = TokenListViewController(textDocumentProxy: textDocumentProxy,
                                                                  keyboardViewController: self)
            view.addSubview(tokenListViewController.view)
            let seperator = UIView(frame: CGRect(x: 0,
                                                 y: 0,
                                                 width: view.frame.width,
                                                 height: 1))
            seperator.backgroundColor = UIColor.lightGray
            self.tokenListViewController?.view.addSubview(seperator)
        }
    }
}
