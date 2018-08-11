//
//  TokenDetails.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 11/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import Foundation
import OneTimePassword
import Base32

class TokenDetails {
    let issuer: String
    let name: String
    let secret: String
    let digitCount: Int = 6
    let algorithm: Generator.Algorithm = .sha1

    init(issuer: String, name: String, secret: String) {
        self.issuer = issuer
        self.name = name
        self.secret = secret
    }
}
