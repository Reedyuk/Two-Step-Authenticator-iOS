//
//  ASProgressRingContainer.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 13/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ASProgressRingContainer: ASDisplayNode {
    var progressView: ProgressRingView?

    override init() {
        super.init()
        backgroundColor = .lightGray
        cornerRadius = 5.0
        clipsToBounds = true
        progressView = ProgressRingView(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
        progressView?.tintColor = UIColor.white
    }

    override func didLoad() {
        if let progressView = self.progressView {
            view.addSubview(progressView)
            progressView.center = CGPoint(x: 22, y: 22)
        }
    }
}
