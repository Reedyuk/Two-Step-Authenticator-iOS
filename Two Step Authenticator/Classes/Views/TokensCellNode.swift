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

//shared with keyboard and app
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
        container.backgroundColor = Colours.defaultButtonBackground
        container.cornerRadius = 5
        container.clipsToBounds = true
        addSubnode(tokenName)
        addSubnode(tokenValue)
        tokenName.attributedText = String.formatLabel(text: "\(token.issuer) \(token.name)",
                                                      font: Fonts.standardTextFontLight.withSize(12),
                                                      textColour: Colours.defaultText)
        if let currentPassword = token.currentPassword {
            tokenValue.attributedText = String.formatLabel(text: currentPassword,
                                                           font: UIFont.systemFont(ofSize: 18),
                                                           textColour: Colours.defaultText)
        }
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let headerVertical = ASStackLayoutSpec(direction: .vertical,
                                               spacing: 5,
                                               justifyContent: .center,
                                               alignItems: .center,
                                               children: [tokenName, tokenValue])
        let backgroundLayer = ASOverlayLayoutSpec(child: container, overlay: headerVertical)
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 10),
                                 child: backgroundLayer)
    }
}
