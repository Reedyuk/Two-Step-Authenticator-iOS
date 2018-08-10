//
//  AddTokenViewController.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 10/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class AddTokenViewController: ASViewController<ASTableNode> {

    init() {
        super.init(node: ASTableNode())
        node.backgroundColor = UIColor.gray
        node.delegate = self
        node.dataSource = self
        node.allowsSelection = false
        node.view.separatorStyle = .none
        title = Strings.AddTokenViewController.title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }

    override func viewDidLoad() {
        node.view.tableFooterView = UIView()
    }

}

extension AddTokenViewController: ASTableDataSource, ASTableDelegate {

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let cell = TokenCellNode()
        return cell
    }

    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
    }

}
