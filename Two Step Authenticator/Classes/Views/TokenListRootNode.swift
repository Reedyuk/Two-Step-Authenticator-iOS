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

    var backButton: ASButtonNode?
    var switchButton: ASButtonNode?
    let progressView = ASProgressRingContainer()
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

    private let showSwitch = true

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
        if showSwitch {
            let switchButton = ASButtonNode()
            addSubnode(switchButton)
            switchButton.addTarget(self,
                                 action: #selector(switchButtonPressed),
                                 forControlEvents: .touchUpInside)
            styleButton(button: switchButton)
            switchButton.setImage(UIImage(named: "NextKeyboard"), for: .normal)
            self.switchButton = switchButton
        } else {
            let backButton = ASButtonNode()
            addSubnode(backButton)
            backButton.addTarget(self,
                                 action: #selector(backButtonPressed),
                                 forControlEvents: .touchUpInside)
            styleButton(button: backButton)
            backButton.setImage(UIImage(named: "android-back"), for: .normal)
            self.backButton = backButton
        }
        addSubnode(progressView)
    }

    override func didLoad() {
        timer = Timer.scheduledTimer(withTimeInterval: 10, repeats: true, block: { (_) in
            self.refreshTokens()
        })
    }

    func styleButton(button: ASButtonNode) {
        button.cornerRadius = 5.0
        button.clipsToBounds = true
        button.layer.masksToBounds = false
        button.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        button.layer.shadowRadius = 0.0
        button.layer.shadowOpacity = 0.35
        button.backgroundColor = .lightGray
        button.style.preferredSize = CGSize(width: 44, height: 44)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        divider.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 1)
        tableNode.style.preferredSize = CGSize(width: constrainedSize.max.width, height: constrainedSize.max.height)
        progressView.style.preferredSize = CGSize(width: 44, height: 44)
        let button: ASButtonNode
        if let switchButton = self.switchButton {
            button = switchButton
        } else {
            button = self.backButton!
        }
        let backInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: CGFloat.infinity,
                                                               left: 10,
                                                               bottom: 10,
                                                               right: CGFloat.infinity),
                                          child: button)
        let progressInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: CGFloat.infinity,
                                                               left: CGFloat.infinity,
                                                               bottom: 10,
                                                               right: 10),
                                              child: progressView)
        let stackVertical = ASStackLayoutSpec.vertical()
        stackVertical.spacing = 0
        stackVertical.children = [divider, tableNode]
        let rootOverlay = ASOverlayLayoutSpec(child: stackVertical, overlay: backInset)
        return ASOverlayLayoutSpec(child: rootOverlay, overlay: progressInset)
    }

    @objc func backButtonPressed() {
        tokenListViewController?.dismiss(animated: true)
    }

    @objc func switchButtonPressed() {
        tokenListViewController?.keyboardViewController.advanceToNextInputMode()
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

        let displayTime = DisplayTime.currentDisplayTime()
        let lastRefreshTime = tokens.reduce(.distantPast) { (lastRefreshTime, persistentToken) in
            max(lastRefreshTime, persistentToken.lastRefreshTime(before: displayTime))
        }
        let nextRefreshTime = tokens.reduce(.distantFuture) { (nextRefreshTime, persistentToken) in
            min(nextRefreshTime, persistentToken.nextRefreshTime(after: displayTime))
        }
        let progressRingVM = ProgressRingViewModel(startTime: lastRefreshTime, endTime: nextRefreshTime)
        progressView.progressView?.update(with: progressRingVM)
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
