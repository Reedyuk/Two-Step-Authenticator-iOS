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
        node.backgroundColor = Colours.defaultViewControllerBackground
        title = Strings.TokensViewController.title
        node.tableNode.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        let addTokenButton = UIBarButtonItem(barButtonSystemItem: .add,
                                             target: self,
                                             action: #selector(addTokenButtonPressed))
        navigationItem.rightBarButtonItem = addTokenButton
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        node.tableNode.reloadData()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }

    @objc func addTokenButtonPressed() {
        navigationController?.pushViewController(AddTokenViewController(), animated: true)
    }

}
