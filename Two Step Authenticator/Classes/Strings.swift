//
//  Strings.swift
//  TabMarvelApp
//
//  Created by Andrew Reed on 07/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import Foundation

public struct Strings {
    struct ActionButtons {
        public static let back = "Back"
        public static let okButton = "OK"
    }

    struct Home {
        public static let title = "Two Step Authenticator"
    }

    struct HowTo {
        public static let title = "How To?"
        public static let header = "The Two Step Authenticator keyboard needs to be enabled in the settings app"
        public static let settings = "Go to Settings"
        public static let general = "Tap on General"
        public static let keyboard = "Tap on Keyboard"
        public static let keyboards = "Tap on Keyboards"
        public static let addKeyboard = "Add New Keyboard..."
        public static let selectTwoFactor = "Select Two Step Authenticator"
        public static let selectTwoFactorTwoFactor = "Tap TSAKeyboard - Two Step Authenticator"
        public static let allowFullAcess = "'Allow Full Access'"
        public static let allow = "Allow"
        public static let done = "Tap Done"
    }

    struct TokensViewController {
        public static let title = "Tokens"
    }

    struct AddTokenViewController {
        public static let title = "Add Token"
    }

    struct Errors {
        public static let tokenSaveFailedTitle = "Token Save Failure"
        public static let tokenSaveFailedMessage = "We could'nt save the token, please try again."
        public static let tokenDetailsInvalidTitle = "Token Details Invalid"
        public static let tokenDetailsInvalidMessage = "Some token details are invalid"
    }
}
