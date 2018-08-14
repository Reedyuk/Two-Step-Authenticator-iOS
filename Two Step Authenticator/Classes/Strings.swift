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
