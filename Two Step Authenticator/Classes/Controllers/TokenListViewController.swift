//
//  TokenListViewController.swift
//  TSAKeyboard
//
//  Created by Andrew Reed on 08/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import OneTimePassword

class TokenListViewController: ASViewController<TokenListRootNode> {

    let textDocumentProxy: UITextDocumentProxy

    init(textDocumentProxy: UITextDocumentProxy) {
        self.textDocumentProxy = textDocumentProxy
        super.init(node: TokenListRootNode())
        node.tokenListViewController = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let defaults = UserDefaults(suiteName: "Two-Step-Authenticator")
        if let tokens = defaults?.object(forKey: "tokenDetails") as? [Token] {
            print(tokens)
        }
    }
}
