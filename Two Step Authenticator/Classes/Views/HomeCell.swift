//
//  HomeCell.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 14/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HomeCell: ASCellNode {

    let mainText = ASTextNode()
    let container = ASDisplayNode()

    init(text: String) {
        super.init()
        selectionStyle = .none
        addSubnode(container)
        container.backgroundColor = Colours.defaultButtonBackground
        container.cornerRadius = 5
        container.clipsToBounds = true
        addSubnode(mainText)
        let style = NSMutableParagraphStyle()
        style.alignment = NSTextAlignment.center
        mainText.attributedText = String.formatLabel(text: text,
                                                     font: Fonts.standardTextFont.withSize(18),
                                                     textColour: Colours.defaultText,
                                                     style: style)
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let textVertical = ASStackLayoutSpec(direction: .vertical,
                                             spacing: 0,
                                             justifyContent: .center,
                                             alignItems: .center,
                                             children: [mainText])
        let backgroundLayer = ASOverlayLayoutSpec(child: container, overlay: textVertical)
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 10, bottom: 5, right: 10),
                                 child: backgroundLayer)
    }
}
