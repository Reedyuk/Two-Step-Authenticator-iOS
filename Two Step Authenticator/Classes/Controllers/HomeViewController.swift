//
//  HomeViewController.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 10/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HomeViewController: ASViewController<ASTableNode> {

    init() {
        super.init(node: ASTableNode())
        node.delegate = self
        node.dataSource = self
        node.backgroundColor = UIColor.white
        title = Strings.Home.title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }
}

extension HomeViewController: ASTableDataSource, ASTableDelegate {

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return CellType.cells().count
    }

    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let cell = ASTextCellNode()
        cell.text = CellType.cells()[indexPath.row].rawValue
        return cell
    }

    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        switch CellType.cells()[indexPath.row] {
        case .aboutCell:
            break
        case .howToCell:
            break
        case .tokenCell:
            let tokensViewController = TokensViewController()
            navigationController?.pushViewController(tokensViewController, animated: true)
        }
        tableNode.deselectRow(at: indexPath, animated: true)
    }
}

private enum CellType: String {

    case howToCell = "How to setup"
    case tokenCell = "Tokens"
    case aboutCell = "About"

    static func cells() -> [CellType] {
        let cellTypes: [CellType] = [.howToCell, .tokenCell, .aboutCell]
        return cellTypes
    }

}
