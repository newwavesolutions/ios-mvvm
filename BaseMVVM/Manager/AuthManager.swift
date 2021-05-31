//
//  AuthManager.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/22/20.
//  Copyright © 2020 thoson.it. All rights reserved.

import Foundation
import ObjectMapper
import RxSwift
import RxCocoa
import KeychainAccess

class AuthManager {
    
    /// The default singleton instance.
    static let shared = AuthManager()
    
    // MARK: - Properties
    let tokenKey = "TokenKey"
    let usernameKey = "UsernameKey"
    let passwordKey = "PasswordKey"
    let keychain = Keychain(service: Bundle.main.bundleIdentifier ?? "com.thoson.it")
    
    let loggedIn = BehaviorRelay<Bool>(value: false)
    
    init() {
        loggedIn.accept(token != nil)
    }
    
    // MARK: - Token
    
    //    var token: Token? {
    //        get {
    //            guard let jsonString = UserDefaults.standard.object(forKey: Configs.UserDefaultsKeys.OAuthToken) as? String else {
    //                return nil
    //            }
    //            return Mapper<Token>().map(JSONString: jsonString)
    //        }
    //        set {
    //            if let token = newValue, let jsonString = token.toJSONString() {
    //                UserDefaults.standard.set(jsonString, forKey: Configs.UserDefaultsKeys.OAuthToken)
    //                loggedIn.accept(true)
    //            } else {
    //                UserDefaults.standard.set(nil, forKey: Configs.UserDefaultsKeys.OAuthToken)
    //                loggedIn.accept(false)
    //            }
    //        }
    //    }
    var token: Token? {
        get {
            guard let jsonString = keychain[tokenKey] else { return nil }
            return Mapper<Token>().map(JSONString: jsonString)
        }
        set {
            if let token = newValue, let jsonString = token.toJSONString() {
                keychain[tokenKey] = jsonString
                loggedIn.accept(true)
            } else {
                keychain[tokenKey] = nil
                loggedIn.accept(false)
            }
        }
    }
    
    // MARK: - Usernam & Password
    var username: String? {
        get {
            return keychain[usernameKey]
        }
        set {
            if let username = newValue {
                keychain[usernameKey] = username
            } else {
                keychain[usernameKey] = nil
            }
        }
    }
    
    var password: String? {
        get {
            return keychain[passwordKey]
        }
        set {
            if let password = newValue {
                keychain[passwordKey] = password
            } else {
                keychain[passwordKey] = nil
            }
        }
    }
}
