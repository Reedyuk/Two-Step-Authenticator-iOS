//
//  HowDisplayNode.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 14/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HowDisplayNode: ASDisplayNode {
    let tableNode = ASTableNode()
    let settingsButton = ASButtonNode()

    override init() {
        super.init()
        addSubnode(tableNode)
        addSubnode(settingsButton)
        tableNode.delegate = self
        tableNode.dataSource = self
        tableNode.view.separatorStyle = .none
        tableNode.allowsSelection = false
        tableNode.backgroundColor = Colours.defaultViewControllerBackground
        settingsButton.setTitle(Strings.HowTo.settings,
                                with: Fonts.standardTextFont,
                                with: Colours.defaultText, for: .normal)
        settingsButton.backgroundColor = Colours.defaultButtonBackground
        settingsButton.addTarget(self,
                                 action: #selector(settingsButtonPressed),
                                 forControlEvents: .touchUpInside)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }

    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        settingsButton.style.preferredSize = CGSize(width: constrainedSize.max.width, height: 50)
        let tableInset = ASInsetLayoutSpec(insets: UIEdgeInsets.zero, child: tableNode)
        let settingsButtonInset = ASInsetLayoutSpec(insets: UIEdgeInsets(top: CGFloat.infinity,
                                                                         left: 0,
                                                                         bottom: 0,
                                                                         right: 0),
                                                    child: settingsButton)
        return ASOverlayLayoutSpec(child: tableInset, overlay: settingsButtonInset)
    }

    @objc func settingsButtonPressed() {
        if let settingsUrl = URL(string: UIApplicationOpenSettingsURLString) {
            UIApplication.shared.open(settingsUrl, options: [:], completionHandler: nil)
        }
    }
}

extension HowDisplayNode: ASTableDataSource, ASTableDelegate {

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return CellType.cells().count
    }

    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        switch CellType.cells()[indexPath.row] {
        case .header:
            let cell = ASTextCellNode()
            let style = NSMutableParagraphStyle()
            style.alignment = NSTextAlignment.center
            cell.textNode.attributedText = String.formatLabel(text: Strings.HowTo.header,
                                                              font: Fonts.standardTextFont,
                                                              textColour: Colours.defaultText,
                                                              style: style)
            return cell
        case .settings:
            return HowCell(number: "1", text: Strings.HowTo.settings, image: UIImage(named: "settings"))
        case .general:
            return HowCell(number: "2", text: Strings.HowTo.general, image: UIImage(named: "settings-more"))
        case .keyboard:
            return HowCell(number: "3", text: Strings.HowTo.keyboard, image: nil)
        case .keyboards:
            return HowCell(number: "4", text: Strings.HowTo.keyboards, image: nil)
        case .addNewKeyboard:
            return HowCell(number: "5", text: Strings.HowTo.addKeyboard, image: nil)
        case .selectTwoFactor:
            return HowCell(number: "6", text: Strings.HowTo.selectTwoFactor, image: nil)
        case .selectTwoFactorTwoFactor:
            return HowCell(number: "7", text: Strings.HowTo.selectTwoFactorTwoFactor, image: nil)
        case .allowFullAccess:
            return HowCell(number: "8", text: Strings.HowTo.allowFullAcess, image: UIImage(named: "switch"))
        case .allow:
            return HowCell(number: "9", text: Strings.HowTo.allow, image: nil)
        case .tapDone:
            return HowCell(number: "10", text: Strings.HowTo.done, image: nil)
        }
    }
}

private enum CellType {

    case header
    case settings
    case general
    case keyboard
    case keyboards
    case addNewKeyboard
    case selectTwoFactor
    case selectTwoFactorTwoFactor
    case allowFullAccess
    case allow
    case tapDone

    static func cells() -> [CellType] {
        return [.header, .settings, .general, .keyboard, .keyboards,
                .addNewKeyboard, .selectTwoFactor, .selectTwoFactorTwoFactor,
                .allowFullAccess, .allow, .tapDone]
    }

}
