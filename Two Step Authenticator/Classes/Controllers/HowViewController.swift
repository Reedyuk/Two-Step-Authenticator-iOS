//
//  HowViewController.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 14/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit
import AsyncDisplayKit

class HowViewController: ASViewController<HowDisplayNode> {

    let tableNode = ASTableNode()

    init() {
        super.init(node: HowDisplayNode())
        title = Strings.HowTo.title
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("storyboards are incompatible with truth and beauty")
    }
}
