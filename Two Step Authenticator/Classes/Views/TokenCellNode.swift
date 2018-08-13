//
//  TokenCellNode.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 10/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import Foundation
import UIKit
import AsyncDisplayKit
import Base32

class TokenCellNode: ASCellNode {

    let accountName = ASEditableTextNode()
    let accountUserName = ASEditableTextNode()
    let secretKey = ASEditableTextNode()
    let addButton = ASButtonNode()
    let addTokenViewController: AddTokenViewController

    init(addTokenViewController: AddTokenViewController) {
        self.addTokenViewController = addTokenViewController
        super.init()
        addSubnode(accountName)
        addSubnode(accountUserName)
        addSubnode(secretKey)
        addSubnode(addButton)

        styleInput(input: accountName, placeholder: "Account Name")
        styleInput(input: accountUserName, placeholder: "Account UserName/Email")
        styleInput(input: secretKey, placeholder: "Secret Key")

        addButton.backgroundColor = UIColor.lightGray
        addButton.setTitle("Add Token",
                           with: UIFont.systemFont(ofSize: 12),
                           with: UIColor.white,
                           for: .normal)
        addButton.cornerRadius = 5
        addButton.clipsToBounds = true
        addButton.addTarget(self, action: #selector(addTokenButtonPressed), forControlEvents: .touchUpInside)
    }

    func styleInput(input: ASEditableTextNode, placeholder: String) {
        let style = NSMutableParagraphStyle()
        style.lineHeightMultiple = 1.2
        style.alignment = NSTextAlignment.natural
        input.textContainerInset = UIEdgeInsets(top: 12, left: 15, bottom: 12, right: 15)
        input.returnKeyType = .done
        input.attributedPlaceholderText = String.formatLabel(text: placeholder,
                                                             font: UIFont.systemFont(ofSize: 12),
                                                             textColour: UIColor.gray,
                                                             style: style)
        input.typingAttributes = [NSAttributedStringKey.font.rawValue: UIFont.systemFont(ofSize: 12),
                                                NSAttributedStringKey.foregroundColor.rawValue: UIColor.black,
                                                NSAttributedStringKey.paragraphStyle.rawValue: style]
        input.maximumLinesToDisplay = 1
        input.borderWidth = 1
        input.borderColor = UIColor.lightGray.cgColor
        input.cornerRadius = 5
        input.clipsToBounds = true
        input.backgroundColor = UIColor.white
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        accountName.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 44)
        accountUserName.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 44)
        secretKey.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 44)
        addButton.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 44)

        let stackLayout = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 10,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [accountName, accountUserName, secretKey, addButton])
        let insetStack = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10,
                                                                left: 10,
                                                                bottom: 0,
                                                                right: 10),
                                           child: stackLayout)
        return insetStack
    }

    @objc func addTokenButtonPressed() {
        let tokenDetails = TokenDetails(issuer: accountName.textView.text,
                                        name: accountUserName.textView.text,
                                        secret: secretKey.textView.text)
        addTokenViewController.submitToken(tokenDetails: tokenDetails)
    }

}
