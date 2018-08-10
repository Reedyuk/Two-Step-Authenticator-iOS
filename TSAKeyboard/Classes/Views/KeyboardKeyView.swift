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

    var defaultBackgroundColor: UIColor = .white
    var highlightBackgroundColor: UIColor = .lightGray
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
        if ((key as? SpecialKey) == nil) {
            keyTitle = Settings.sharedInstance.shiftEnabled ? keyTitle.uppercased() : keyTitle.lowercased()
        }
        title.attributedText = String.formatLabel(text: keyTitle,
                                                  font: UIFont.boldSystemFont(ofSize: 18),
                                                  textColour: UIColor.black)
        addSubnode(title)
        if let image = key.image,
            let imageView = self.imageView {
            imageView.image = image
            addSubnode(imageView)
        }
    }

    func styleNode() {
        keyBackground.backgroundColor = defaultBackgroundColor
        keyBackground.cornerRadius = 5.0
        keyBackground.clipsToBounds = true
        keyBackground.layer.masksToBounds = false
        keyBackground.layer.shadowOffset = CGSize(width: 0, height: 1.0)
        keyBackground.layer.shadowRadius = 0.0
        keyBackground.layer.shadowOpacity = 0.35
        backgroundColor = UIColor.clear
    }

    func animateKeyPress() {
        UIView.animate(withDuration: 0.05, animations: {
            self.keyBackground.backgroundColor = self.highlightBackgroundColor
        }, completion: { completed in
            self.keyBackground.backgroundColor = self.defaultBackgroundColor
        })
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let stackLayout: ASStackLayoutSpec
        if let imageView = self.imageView {
            stackLayout = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 0,
                                            justifyContent: .center, alignItems: .center, children: [imageView])
        } else {
            stackLayout = ASStackLayoutSpec(direction: .vertical,
                                            spacing: 0,
                                            justifyContent: .center, alignItems: .center, children: [title])
        }
        let stackInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: defaultMargin,
                                                                left: defaultMargin,
                                                                bottom: defaultMargin,
                                                                right: defaultMargin),
                                           child: stackLayout)
        let backgroundInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: 0, left: 0, bottom: 1, right: 0),
                                           child: keyBackground)
        return ASBackgroundLayoutSpec(child: stackInset, background: backgroundInset)
    }
}
