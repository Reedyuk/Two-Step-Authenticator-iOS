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

    init(token: Token) {
        self.token = token
        super.init()
        addSubnode(tokenName)
        addSubnode(tokenValue)
        tokenName.attributedText = String.formatLabel(text: token.issuer,
                                                      font: UIFont.systemFont(ofSize: 12),
                                                      textColour: UIColor.blue)
        if let currentPassword = token.currentPassword {
            tokenValue.attributedText = String.formatLabel(text: currentPassword,
                                                           font: UIFont.systemFont(ofSize: 12),
                                                           textColour: UIColor.blue)
        }
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayout = ASStackLayoutSpec.horizontal()
        stackLayout.children = [tokenName, tokenValue]
        return stackLayout
    }
}
