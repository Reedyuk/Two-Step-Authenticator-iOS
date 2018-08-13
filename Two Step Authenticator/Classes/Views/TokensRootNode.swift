//
//  TokensRootNode.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 10/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import OneTimePassword

class TokensRootNode: ASDisplayNode {

    let tableNode: ASTableNode
    var tokens: [PersistentToken] {
        if let store = Settings.sharedInstance.store {
            return store.persistentTokens
        }
        return [PersistentToken]()
    }
    var timer: Timer?

    lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self,
                                 action: #selector(TokensRootNode.handleRefresh(_:)),
                                 for: UIControlEvents.valueChanged)
        refreshControl.tintColor = UIColor.black
        return refreshControl
    }()

    override init() {
        tableNode = ASTableNode()
        super.init()
        addSubnode(tableNode)
        tableNode.backgroundColor = UIColor.gray
        tableNode.view.separatorStyle = .none
        tableNode.view.addSubview(refreshControl)
        tableNode.delegate = self
        tableNode.dataSource = self
    }

    override func didLoad() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (_) in
            self.refreshTokens()
        })
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: tableNode)
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

extension TokensRootNode: ASTableDataSource, ASTableDelegate {

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return tokens.count
    }

    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let cell = TokensCellNode(token: tokens[indexPath.row].token)
        cell.style.preferredSize = CGSize(width: tableNode.frame.width, height: 64)
        return cell
    }

    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        if let password = tokens[indexPath.row].token.currentPassword {
            UIPasteboard.general.string = password
        }
    }
}
