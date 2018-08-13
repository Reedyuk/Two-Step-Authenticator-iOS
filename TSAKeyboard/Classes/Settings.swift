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
    var store: TokenStore?
    var shiftEnabled = false

    init() {
    }

    func initalise() {
        if let userDefaults = UserDefaults(suiteName: "group.two.step.authenticator") {
            do {
                store = try KeychainTokenStore(keychain: Keychain.sharedInstance,
                                               userDefaults: userDefaults)
            } catch {
                fatalError("Failed to load token store: \(error)")
            }
        }
    }
}
