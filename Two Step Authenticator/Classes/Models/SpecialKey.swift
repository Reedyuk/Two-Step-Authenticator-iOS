//
//  SpecialKey.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 09/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import UIKit

class SpecialKey: Key {
    let type: SpecialKeyTypes

    init(title: String, image: UIImage? = nil, type: SpecialKeyTypes) {
        self.type = type
        super.init(title: title, image: image)
    }
}

enum SpecialKeyTypes {
    case token
    case switchKeyboard
    case spacebar
    case shift
    case backspace
    case returnKey
}
