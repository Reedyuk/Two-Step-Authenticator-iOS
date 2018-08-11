//
//  TokensCellNode.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 11/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit
import OneTimePassword

class TokensCellNode: ASCellNode {
    let token: Token
    let tokenName = ASTextNode()
    let tokenValue = ASTextNode()
    let container = ASDisplayNode()

    init(token: Token) {
        self.token = token
        super.init()
        selectionStyle = .none
        addSubnode(container)
        container.backgroundColor = UIColor.lightGray
        container.cornerRadius = 5
        container.clipsToBounds = true
        addSubnode(tokenName)
        addSubnode(tokenValue)
        tokenName.attributedText = String.formatLabel(text: token.issuer,
                                                      font: UIFont.systemFont(ofSize: 18),
                                                      textColour: UIColor.white)
        if let currentPassword = token.currentPassword {
            tokenValue.attributedText = String.formatLabel(text: currentPassword,
                                                           font: UIFont.systemFont(ofSize: 18),
                                                           textColour: UIColor.white)
        }
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let headerStackSpec = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: 10,
                                                justifyContent: .start,
                                                alignItems: .center,
                                                children: [tokenName, tokenValue])
        let headerInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10), child: headerStackSpec)
        let headerVertical = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 0,
                                               justifyContent: .center,
                                               alignItems: .center,
                                               children: [headerInset])
        let backgroundLayer = ASOverlayLayoutSpec(child: container, overlay: headerVertical)
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
                                 child: backgroundLayer)
    }
}
