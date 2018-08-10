//
//  TokensRootNode.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 10/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class TokensRootNode: ASDisplayNode {

    let tableNode: ASTableNode

    override init() {
        tableNode = ASTableNode()
        super.init()
        addSubnode(tableNode)
        tableNode.delegate = self
        tableNode.dataSource = self
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: tableNode)
    }
}

extension TokensRootNode: ASTableDataSource, ASTableDelegate {

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let cell = ASCellNode()
        cell.style.preferredSize = CGSize(width: tableNode.frame.width, height: 44)
        return cell
    }

    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
    }
}
