//
//  TokenListRootNode.swift
//  TSAKeyboard
//
//  Created by Andrew Reed on 08/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class TokenListRootNode: ASDisplayNode {

    let backButton = ASButtonNode()
    let tableNode: ASTableNode
    var tokenListViewController: TokenListViewController?
    
    override init() {
        tableNode = ASTableNode()
        super.init()
        addSubnode(tableNode)
        tableNode.delegate = self
        tableNode.dataSource = self
        backButton.setTitle("Back",
                            with: UIFont.systemFont(ofSize: 12),
                            with: UIColor.blue,
                            for: .normal)
        backButton.style.preferredSize = CGSize(width: 44, height: 44)
        addSubnode(backButton)
        backButton.addTarget(self,
                             action: #selector(backButtonPressed),
                             forControlEvents: .touchUpInside)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let backInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: CGFloat.infinity,
                                                               left: 0,
                                                               bottom: 0,
                                                               right: CGFloat.infinity),
                                          child: backButton)
        let tableInset = ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: tableNode)
        return ASOverlayLayoutSpec(child: tableInset, overlay: backInset)
    }

    @objc func backButtonPressed() {
        tokenListViewController?.dismiss(animated: true)
    }
}

extension TokenListRootNode: ASTableDataSource, ASTableDelegate {

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 3
    }

    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let cell = ASCellNode()
        cell.backgroundColor = UIColor.green
        cell.style.preferredSize = CGSize(width: tableNode.frame.width, height: 44)
        return cell
    }

    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        if let tokenListViewController = self.tokenListViewController {
            (tokenListViewController.textDocumentProxy as UIKeyInput).insertText("Test")
        }
        tableNode.deselectRow(at: indexPath, animated: true)
    }
}
