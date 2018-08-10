//
//  TokensViewController.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 10/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class TokensViewController: ASViewController<TokensRootNode> {

    init() {
        super.init(node: TokensRootNode())
        node.backgroundColor = UIColor.gray
        title = Strings.TokensViewController.title
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let addTokenButton = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(addTokenButtonPressed))
        navigationItem.rightBarButtonItem = addTokenButton
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }

    @objc func addTokenButtonPressed() {
        navigationController?.pushViewController(AddTokenViewController(), animated: true)
    }
}
