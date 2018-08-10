//
//  KeyboardNodeViewController.swift
//  TSAKeyboard
//
//  Created by Andrew Reed on 09/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class KeyboardNodeViewController: ASViewController<ASTableNode> {

    static let firstRowOfKeys = [Key(title: "Q"),
                                 Key(title: "W"),
                                 Key(title: "E"),
                                 Key(title: "R"),
                                 Key(title: "T"),
                                 Key(title: "Y"),
                                 Key(title: "U"),
                                 Key(title: "I"),
                                 Key(title: "O"),
                                 Key(title: "P")]
    static let secondRowOfKeys = [Key(title: "A"),
                                 Key(title: "S"),
                                 Key(title: "D"),
                                 Key(title: "F"),
                                 Key(title: "G"),
                                 Key(title: "H"),
                                 Key(title: "J"),
                                 Key(title: "K"),
                                 Key(title: "L")]
    static let thirdRowOfKeys = [SpecialKey(title: Strings.shift,
                                            image: nil,
                                            type: .shift),
                                 Key(title: "Z"),
                                  Key(title: "X"),
                                  Key(title: "C"),
                                  Key(title: "V"),
                                  Key(title: "B"),
                                  Key(title: "N"),
                                  Key(title: "M"),
                                  SpecialKey(title: "",
                                             image: UIImage(named: "Backspace"),
                                             type: .backspace)]
    static let fourthRowOfKeys = [SpecialKey(title: Strings.auth,
                                             image: nil,
                                             type: .token),
                                  SpecialKey(title: "",
                                             image: UIImage(named: "NextKeyboard"),
                                             type: .switchKeyboard),
                                  SpecialKey(title: Strings.space,
                                             image: nil,
                                             type: .spacebar),
                                  SpecialKey(title: Strings.returnKey,
                                             image: nil,
                                             type: .returnKey)]
    static let keys = [KeyboardNodeViewController.firstRowOfKeys,
                       KeyboardNodeViewController.secondRowOfKeys,
                       KeyboardNodeViewController.thirdRowOfKeys,
                       KeyboardNodeViewController.fourthRowOfKeys]

    let textDocumentProxy: UITextDocumentProxy
    let parentInputViewController: KeyboardViewController

    init(textDocumentProxy: UITextDocumentProxy, parentInputViewController: KeyboardViewController) {
        self.parentInputViewController = parentInputViewController
        self.textDocumentProxy = textDocumentProxy
        super.init(node: ASTableNode())
        node.delegate = self
        node.dataSource = self
        node.allowsSelection = false
        node.view.separatorStyle = .none
        node.view.isScrollEnabled = false
        node.backgroundColor = Colours.defaultBackground
    }

    func calculateButtonMinWidth() -> CGFloat {
        let fullParentWidth = parentInputViewController.view.frame.width - 10
        let keySpacingTotal = KeyboardNodeRowCell.cellSpacing *
            CGFloat(KeyboardNodeViewController.keys[0].count)
        return (fullParentWidth - keySpacingTotal) /
            CGFloat(KeyboardNodeViewController.keys[0].count)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }
}

extension KeyboardNodeViewController: ASTableDataSource, ASTableDelegate {

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return KeyboardNodeViewController.keys.count
    }

    func tableNode(_ tableNode: ASTableNode, constrainedSizeForRowAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRangeMake(CGSize(width: tableNode.frame.width,
                                      height: CGFloat.leastNonzeroMagnitude),
                               CGSize(width: tableNode.frame.width,
                                      height: CGFloat.greatestFiniteMagnitude))
    }

    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let cell = KeyboardNodeRowCell(keys: KeyboardNodeViewController.keys[indexPath.row],
                                       textDocumentProxy: textDocumentProxy,
                                       inputViewController: parentInputViewController,
                                       parentViewController: self,
                                       buttonMinWidth: calculateButtonMinWidth())
        cell.style.preferredSize = CGSize(width: tableNode.frame.width - 10, height: 49)
        return cell
    }

}
