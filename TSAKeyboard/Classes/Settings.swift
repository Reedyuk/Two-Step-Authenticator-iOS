//
//  Settings.swift
//  TSAKeyboard
//
//  Created by Andrew Reed on 10/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import Foundation
import OneTimePassword

class Settings {
    static let sharedInstance = Settings()

    var shiftEnabled = false
    var tokens: [Token] = [Token]()
}
