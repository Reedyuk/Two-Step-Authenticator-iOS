//
//  KeyboardNodeRowCell.swift
//  TSAKeyboard
//
//  Created by Andrew Reed on 09/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class KeyboardNodeRowCell: ASCellNode {

    private let keys: [Key]

    //need a config block to define the elements in a row.
    private var collectionView: ASCollectionNode
    private let flowLayout = UICollectionViewFlowLayout()
    let textDocumentProxy: UITextDocumentProxy
    let inputViewController: KeyboardViewController?
    let parentViewController: KeyboardNodeViewController
    var contentSize: CGSize = CGSize.zero
    static let cellSpacing = CGFloat(5)
    var buttonMinWidth = CGFloat(30)

    init(keys: [Key],
         textDocumentProxy: UITextDocumentProxy,
         inputViewController: KeyboardViewController?,
         parentViewController: KeyboardNodeViewController,
         buttonMinWidth: CGFloat = CGFloat(30)) {
        self.parentViewController = parentViewController
        self.inputViewController = inputViewController
        self.textDocumentProxy = textDocumentProxy
        self.keys = keys
        flowLayout.scrollDirection = .horizontal
        flowLayout.minimumLineSpacing = KeyboardNodeRowCell.cellSpacing
        flowLayout.minimumInteritemSpacing = KeyboardNodeRowCell.cellSpacing
        collectionView = ASCollectionNode(collectionViewLayout: flowLayout)
        super.init()
        clipsToBounds = false
        addSubnode(collectionView)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.view.isScrollEnabled = false
        backgroundColor = Colours.defaultBackground
        collectionView.backgroundColor = Colours.defaultBackground
        self.buttonMinWidth = buttonMinWidth
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        return ASInsetLayoutSpec(insets: UIEdgeInsets(top: 5, left: 5, bottom: 0, right: 5),
                                 child: collectionView)
    }

    override func didLoad() {
        collectionView.reloadData()
        collectionView.layoutIfNeeded()
        layoutIfNeeded()
    }

    override func layout() {
        if contentSize != flowLayout.collectionViewContentSize {
            contentSize = flowLayout.collectionViewContentSize
            collectionView.reloadData()
        }
    }
}

extension KeyboardNodeRowCell: ASCollectionDelegate, ASCollectionDataSource {

    func numberOfRows() -> Int {
        return keys.count
    }

    func collectionNode(_ collectionNode: ASCollectionNode, numberOfItemsInSection section: Int) -> Int {
        return numberOfRows()
    }

    func collectionNode(_ collectionNode: ASCollectionNode, nodeForItemAt indexPath: IndexPath) -> ASCellNode {
        return KeyboardKeyView(key: keys[indexPath.row])
    }

    func collectionNode(_ collectionNode: ASCollectionNode,
                        constrainedSizeForItemAt indexPath: IndexPath) -> ASSizeRange {
        return ASSizeRangeMake(CGSize(width: buttonMinWidth,
                                      height: collectionNode.frame.height),
                               CGSize(width: CGFloat.greatestFiniteMagnitude,
                                      height: collectionNode.frame.height))
    }

    func collectionNode(_ collectionNode: ASCollectionNode, didSelectItemAt indexPath: IndexPath) {
        let key = keys[indexPath.row]
        if let specialKey = key as? SpecialKey {
            switch specialKey.type {
            case .switchKeyboard:
                inputViewController?.advanceToNextInputMode()
            case .token:
                //let tokensViewController = TokensViewController()
                //parentViewController.present(tokensViewController, animated: true, completion: nil)
                let tokenListViewController = TokenListViewController(textDocumentProxy: textDocumentProxy)
                parentViewController.present(tokenListViewController, animated: true, completion: nil)
            case .spacebar:
                (textDocumentProxy as UIKeyInput).insertText(" ")
            case .shift:
                Settings.sharedInstance.shiftEnabled = !Settings.sharedInstance.shiftEnabled
                parentViewController.node.reloadSections(IndexSet(integer: 0), with: .automatic)
            case .backspace:
                (textDocumentProxy as UIKeyInput).deleteBackward()
            case .returnKey:
                (textDocumentProxy as UIKeyInput).insertText("\n")
            }
        } else {
            var keyTitle = keys[indexPath.row].title
            keyTitle = Settings.sharedInstance.shiftEnabled ? keyTitle.uppercased() : keyTitle.lowercased()
            (textDocumentProxy as UIKeyInput).insertText(keyTitle)
        }
        if let keyView = collectionNode.nodeForItem(at: indexPath) as? KeyboardKeyView {
            keyView.animateKeyPress()
        }
    }
}

extension KeyboardNodeRowCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        let totalCells = numberOfRows()
        if totalCells > 0 && !contentSize.width.isLessThanOrEqualTo(0) {
            let contentWidth = contentSize.width
            let inset = (collectionView.frame.width - contentWidth) / 2
            return UIEdgeInsets(top: 0, left: inset, bottom: 0, right: inset)
        }
        return UIEdgeInsets.zero
    }
}
