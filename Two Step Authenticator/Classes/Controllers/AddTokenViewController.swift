//
//  AddTokenViewController.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 10/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit
import AsyncDisplayKit
import OneTimePassword
import Base32

class AddTokenViewController: ASViewController<ASTableNode> {

    private let defaultTimerFactor = Generator.Factor.timer(period: 30)

    init() {
        super.init(node: ASTableNode())
        node.backgroundColor = UIColor.gray
        node.delegate = self
        node.dataSource = self
        node.allowsSelection = false
        node.view.separatorStyle = .none
        title = Strings.AddTokenViewController.title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }

    override func viewDidLoad() {
        node.view.tableFooterView = UIView()
    }

}

extension AddTokenViewController: ASTableDataSource, ASTableDelegate {

    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    func tableNode(_ tableNode: ASTableNode, nodeForRowAt indexPath: IndexPath) -> ASCellNode {
        let cell = TokenCellNode(addTokenViewController: self)
        return cell
    }

    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
    }

}

extension AddTokenViewController {

    func submitToken(tokenDetails: TokenDetails) {
        //validate form.
        if let token = validate(tokenDetails: tokenDetails) {
            Settings.sharedInstance.tokens.append(token)
            let defaults = UserDefaults(suiteName: "Two-Step-Authenticator")
            //need to convert the tokens into a property list.
            defaults?.set(Settings.sharedInstance.tokens, forKey: "tokenDetails")
            defaults?.synchronize()
            navigationController?.popViewController(animated: true)
        } else {
            //invalid token.
        }
    }

    func validate(tokenDetails: TokenDetails) -> Token? {
        guard let secretData = MF_Base32Codec.data(fromBase32String: tokenDetails.secret),
            !secretData.isEmpty else {
                print("The secret key is invalid.")
                return nil
        }
        let factor = defaultTimerFactor
        guard let generator = Generator(factor: factor,
                                        secret: secretData,
                                        algorithm: tokenDetails.algorithm,
                                        digits: tokenDetails.digitCount) else {
                                            print("invalid token")
                                            return nil
        }
        return Token(name: tokenDetails.name,
                     issuer: tokenDetails.issuer,
                     generator: generator)
    }
}
