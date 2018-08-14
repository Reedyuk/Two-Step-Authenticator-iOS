//
//  TokenStore.swift
//  Two Step Authenticator
//
//  Created by Andrew Reed on 12/08/2018.
//  Copyright © 2018 Andrew Reed. All rights reserved.
//

import Foundation
import OneTimePassword

protocol TokenStore {
    var persistentTokens: [PersistentToken] { get }

    func addToken(_ token: Token) throws
    func saveToken(_ token: Token, toPersistentToken persistentToken: PersistentToken) throws
    func updatePersistentToken(_ persistentToken: PersistentToken) throws
    func moveTokenFromIndex(_ origin: Int, toIndex destination: Int) throws
    func deletePersistentToken(_ persistentToken: PersistentToken) throws
}

class KeychainTokenStore: TokenStore {
    fileprivate let keychain: Keychain
    private let userDefaults: UserDefaults
    fileprivate(set) var persistentTokens: [PersistentToken]
    private var keychainGroupName: String {
        if let appIdentifierPrefix = Bundle.main.infoDictionary!["AppIdentifierPrefix"] as? String {
            return "\(appIdentifierPrefix)uk.co.andrewreed.Two-Step-Authenticator"
        }
        return ".uk.co.andrewreed.Two-Step-Authenticator"
    }

    // Throws an error if the initial state could not be loaded from the keychain.
    init(keychain: Keychain, userDefaults: UserDefaults) throws {
        self.keychain = keychain
        self.userDefaults = userDefaults

        // Try to load persistent tokens.
        let persistentTokenSet = try keychain.allPersistentTokens()
        let sortedIdentifiers = userDefaults.persistentIdentifiers()

        persistentTokens = persistentTokenSet.sorted(by: {
            let indexOfA = sortedIdentifiers.index(of: $0.identifier)
            let indexOfB = sortedIdentifiers.index(of: $1.identifier)
            switch (indexOfA, indexOfB) {
            case let (.some(indexA), .some(indexB)) where indexA < indexB:
                return true
            default:
                return false
            }
        })
        if persistentTokens.count > sortedIdentifiers.count {
            // If lost tokens were found and appended, save the full list of tokens
            saveTokenOrder()
        }
    }

    fileprivate func saveTokenOrder() {
        let persistentIdentifiers = persistentTokens.map { $0.identifier }
        userDefaults.savePersistentIdentifiers(persistentIdentifiers)
    }
}

extension KeychainTokenStore {
    // MARK: Actions

    func addToken(_ token: Token) throws {
        let newPersistentToken = try keychain.add(token, keychainGroupName: keychainGroupName)
        persistentTokens.append(newPersistentToken)
        saveTokenOrder()
    }

    func saveToken(_ token: Token, toPersistentToken persistentToken: PersistentToken) throws {
        let updatedPersistentToken = try keychain.update(persistentToken, with: token, keychainGroupName: keychainGroupName)
        // Update the in-memory token, which is still the origin of the table view's data
        persistentTokens = persistentTokens.map {
            if $0.identifier == updatedPersistentToken.identifier {
                return updatedPersistentToken
            }
            return $0
        }
    }

    func updatePersistentToken(_ persistentToken: PersistentToken) throws {
        let newToken = persistentToken.token.updatedToken()
        try saveToken(newToken, toPersistentToken: persistentToken)
    }

    func moveTokenFromIndex(_ origin: Int, toIndex destination: Int) {
        let persistentToken = persistentTokens[origin]
        persistentTokens.remove(at: origin)
        persistentTokens.insert(persistentToken, at: destination)
        saveTokenOrder()
    }

    func deletePersistentToken(_ persistentToken: PersistentToken) throws {
        try keychain.delete(persistentToken)
        if let index = persistentTokens.index(of: persistentToken) {
            persistentTokens.remove(at: index)
        }
        saveTokenOrder()
    }
}

// MARK: - Token Order Persistence

private let kOTPKeychainEntriesArray = "TSAKeychainEntries"

private extension UserDefaults {
    func persistentIdentifiers() -> [Data] {
        return array(forKey: kOTPKeychainEntriesArray) as? [Data] ?? []
    }

    func savePersistentIdentifiers(_ identifiers: [Data]) {
        set(identifiers, forKey: kOTPKeychainEntriesArray)
        synchronize()
    }
}

extension PersistentToken {
    func lastRefreshTime(before displayTime: DisplayTime) -> Date {
        switch token.generator.factor {
        case .counter:
            return .distantPast
        case .timer(let period):
            let epoch = displayTime.timeIntervalSince1970
            return Date(timeIntervalSince1970: epoch - epoch.truncatingRemainder(dividingBy: period))
        }
    }

    func nextRefreshTime(after displayTime: DisplayTime) -> Date {
        switch token.generator.factor {
        case .counter:
            return .distantFuture
        case .timer(let period):
            let epoch = displayTime.timeIntervalSince1970
            return Date(timeIntervalSince1970: epoch + (period - epoch.truncatingRemainder(dividingBy: period)))
        }
    }
}
