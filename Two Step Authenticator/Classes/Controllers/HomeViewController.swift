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
        node.view.separatorStyle = .none
        node.backgroundColor = Colours.defaultViewControllerBackground
        title = Strings.Home.title
        node.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        title = Strings.Home.title
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
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
        let cell = HomeCell(text: CellType.cells()[indexPath.row].rawValue)
        cell.style.preferredSize = CGSize(width: tableNode.frame.width, height: 64)
        return cell
    }

    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        switch CellType.cells()[indexPath.row] {
        case .howToCell:
            navigationController?.pushViewController(HowViewController(), animated: true)
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

    static func cells() -> [CellType] {
        let cellTypes: [CellType] = [.howToCell, .tokenCell]
        return cellTypes
    }

}
