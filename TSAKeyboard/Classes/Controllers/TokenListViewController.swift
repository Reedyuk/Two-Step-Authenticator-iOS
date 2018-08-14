//
//  TokenListViewController.swift
//  TSAKeyboard
//
//  Created by Andrew Reed on 08/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class TokenListViewController: ASViewController<TokenListRootNode> {

    let textDocumentProxy: UITextDocumentProxy
    let keyboardViewController: KeyboardViewController

    init(textDocumentProxy: UITextDocumentProxy,
         keyboardViewController: KeyboardViewController) {
        self.textDocumentProxy = textDocumentProxy
        self.keyboardViewController = keyboardViewController
        super.init(node: TokenListRootNode())
        node.tokenListViewController = self
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }
}
