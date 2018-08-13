//
//  TokenListRootNode.swift
//  TSAKeyboard
//
//  Created by Andrew Reed on 08/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import OneTimePassword

class TokenListRootNode: ASDisplayNode {

    let backButton = ASButtonNode()
    let tableNode: ASTableNode
    let divider = ASDisplayNode()
    var tokens: [PersistentToken] {
        if let store = Settings.sharedInstance.store {
            return store.persistentTokens
        }
        return [PersistentToken]()
    }
    var tokenListViewController: TokenListViewController?
    var timer: Timer?
    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(TokenListRootNode.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.black
        return refreshControl
    }()

    override init() {
        tableNode = ASTableNode()
        super.init()
        addSubnode(divider)
        divider.backgroundColor = UIColor.lightGray
        addSubnode(tableNode)
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.separatorStyle = .none
        tableNode.backgroundColor = Colours.defaultBackground
        tableNode.view.addSubview(refreshControl)
        styleButton()
        addSubnode(backButton)
        backButton.addTarget(self,
                             action: #selector(backButtonPressed),
                             forControlEvents: .touchUpInside)
    }

    override func didLoad() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (_) in
            self.refreshTokens()
        })
    }

    func styleButton() {
        backButton.cornerRadius = 5.0
        backButton.clipsToBounds = true
        backButton.layer.masksToBounds = false
        backButton.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        backButton.layer.shadowRadius = 0.0
        backButton.layer.shadowOpacity = 0.35
        backButton.backgroundColor = .lightGray
        backButton.setImage(UIImage(named: "android-back"), for: .normal)
        backButton.style.preferredSize = CGSize(width: 44, height: 44)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        divider.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 1)
        tableNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.height)
        let backInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: CGFloat.infinity,
                                                               left: 10,
                                                               bottom: 10,
                                                               right: CGFloat.infinity),
                                          child: backButton)
        let stackVertical = ASStackLayoutSpec.vertical()
        stackVertical.children = [divider, tableNode]
        return ASOverlayLayoutSpec(child: stackVertical, overlay: backInset)
    }

    @objc func backButtonPressed() {
        tokenListViewController?.dismiss(animated: true)
    }

    @objc func handleRefresh(_ refreshControl: UIRefreshControl) {
        refreshTokens()
    }

    @objc func refreshTokens() {
        for token in tokens {
            do {
                try Settings.sharedInstance.store?.deletePersistentToken(token)
                let updatedToken = token.token.updatedToken()
                try Settings.sharedInstance.store?.addToken(updatedToken)
            } catch {
                print("failed to error")
            }
        }
        tableNode.reloadData()
        refreshControl.endRefreshing()
    }
}

extension TokenListRootNode: ASTableDataSource, ASTableDelegate {

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return tokens.count
    }

    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let cell = TokensCellNode(token: tokens[indexPath.row].token)
        cell.style.preferredSize = CGSize(width: tableNode.frame.width, height: 64)
        return cell
    }

    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        if let tokenListViewController = self.tokenListViewController,
            let tokenPassword = tokens[indexPath.row].token.currentPassword {
            (tokenListViewController.textDocumentProxy as UIKeyInput).insertText(tokenPassword)
        }
        tableNode.deselectRow(at: indexPath, animated: true)
    }
}
