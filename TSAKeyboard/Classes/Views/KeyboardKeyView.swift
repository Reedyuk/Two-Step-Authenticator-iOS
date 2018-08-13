//
//  KeyboardKeyView.swift
//  TSAKeyboard
//
//  Created by Andrew Reed on 09/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class KeyboardKeyView: ASCellNode {

    let defaultMargin: CGFloat

    let title = ASTextNode()
    let imageView: ASImageNode?
    let keyBackground = ASDisplayNode()

    init(key: Key, defaultMargin: CGFloat = CGFloat(5)) {
        if key.image != nil {
            imageView = ASImageNode()
        } else {
            imageView = nil
        }
        self.defaultMargin = defaultMargin
        super.init()
        addSubnode(keyBackground)
        styleNode()
        var keyTitle = key.title
        if (key as? SpecialKey) == nil {
            keyTitle = Settings.sharedInstance.shiftEnabled ? keyTitle.uppercased() : keyTitle.lowercased()
        }
        title.attributedText = String.formatLabel(text: keyTitle,
                                                  font: Fonts.standardTextFontUltraLight,
                                                  textColour: Colours.defaultText)
        addSubnode(title)
        if let image = key.image,
            let imageView = self.imageView {
            imageView.image = image
            imageView.tintColor = Colours.defaultText
            addSubnode(imageView)
        }
    }

    func styleNode() {
        backgroundColor = UIColor.clear
    }

    func animateKeyPress() {
        UIView.animate(withDuration: 0.05, animations: {
            self.keyBackground.backgroundColor = Colours.highlightBackgroundColor
        }, completion: { _ in
            self.keyBackground.backgroundColor = Colours.defaultBackground
        })
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayout: ASStackLayoutSpec
        if let imageView = self.imageView {
            stackLayout = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 0,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [imageView])
        } else {
            stackLayout = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 0,
                                            justifyContent: .center,
                                            alignItems: .center,
                                            children: [title])
        }
        let stackInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: defaultMargin,
                                                                left: defaultMargin,
                                                                bottom: defaultMargin,
                                                                right: defaultMargin),
                                           child: stackLayout)
        let backgroundInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0,
                                                                     left: 0,
                                                                     bottom: 1,
                                                                     right: 0),
                                           child: keyBackground)
        return ASBackgroundLayoutSpec(child: stackInset, background: backgroundInset)
    }
}
