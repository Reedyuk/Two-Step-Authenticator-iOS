//
//  Key.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 09/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit

class Key {
    let title: String
    let image: UIImage?

    init(title: String, image: UIImage? = nil) {
        self.title = title
        self.image = image
    }
}
