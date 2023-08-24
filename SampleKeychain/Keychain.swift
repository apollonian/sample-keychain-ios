//
//  Keychain.swift
//  sample-keychain-ios
//
//  Created by Abhishek Warokar on 23/08/23.
//

import KeychainSwift

public class Keychain {

    // MARK: - Public properties

    public enum Key: String {
        case randomNumber
    }

    /// Shared keychain resource.
    public static let shared = Keychain()

    // MARK: - Private properties

    private let keychain = KeychainSwift()

    // MARK: - Public methods

    /// Retrieves the text value from the keychain that corresponds to the given key.
    public func get(_ key: Key) -> String? {
        return keychain.get(key.rawValue)
    }

    /// Stores the text value in the keychain item with the given key.
    public func set(_ key: Key, _ value: String) {
        keychain.set(value, forKey: key.rawValue, withAccess: .accessibleWhenUnlocked)
    }

    /// Deletes the Keychain item with the given key.
    public func clear(_ key: Key) {
        keychain.delete(key.rawValue)
    }

    /// Deletes all Keychain items.
    public func clearAll() {
        keychain.clear()
    }
}
