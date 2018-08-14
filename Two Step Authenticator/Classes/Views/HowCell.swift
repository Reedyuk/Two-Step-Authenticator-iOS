//
//  HowCell.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 14/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HowCell: ASCellNode {
    let mainText = ASTextNode()
    let imageNode = ASImageNode()
    let numberText = ASTextNode()

    init(number: String, text: String, image: UIImage?) {
        super.init()
        addSubnode(numberText)
        numberText.attributedText = String.formatLabel(text: number,
                                                       font: Fonts.standardTextFont,
                                                       textColour: Colours.defaultText)
        addSubnode(mainText)
        addSubnode(imageNode)
        mainText.attributedText = String.formatLabel(text: text,
                                                     font: Fonts.standardTextFont,
                                                     textColour: Colours.defaultText)
        imageNode.image = image
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let mainTextStack = ASStackLayoutSpec.vertical()
        mainTextStack.style.flexShrink = 1.0
        mainTextStack.style.flexGrow = 1.0
        mainTextStack.children = [mainText]
        let headerStackSpec = ASStackLayoutSpec(direction: .horizontal,
                                                spacing: 40,
                                                justifyContent: .start,
                                                alignItems: .center,
                                                children: [mainTextStack, imageNode])
        let mainInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 10,
                                                               left: 20,
                                                               bottom: 10,
                                                               right: 10),
                                          child: headerStackSpec)
        mainInset.style.flexShrink = 1.0
        mainInset.style.flexGrow = 1.0
        let numberInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10),
                                            child: numberText)
        return ASStackLayoutSpec(direction: .horizontal,
                                 spacing: 0,
                                 justifyContent: .start,
                                 alignItems: .center,
                                 children: [numberInset, mainInset])
    }
}
