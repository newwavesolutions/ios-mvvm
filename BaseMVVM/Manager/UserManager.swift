//
//  UserManager.swift
//  BaseMVVM
//
//  Created by Lê Thọ Sơn on 4/25/20.
//  Copyright © 2020 thoson.it. All rights reserved.
//

import Foundation
import ObjectMapper
import RxSwift
import RxCocoa

class UserManager {
    
    /// The default singleton instance.
    static let shared = UserManager()
    
    let currentUser: BehaviorRelay<User?>
    
    private init() {
        guard let jsonString = UserDefaults.standard.object(forKey: Configs.UserDefaultsKeys.CurrentUser) as? String else {
            currentUser = BehaviorRelay<User?>(value: nil)
            return
        }
        let user = Mapper<User>().map(JSONString: jsonString)
        currentUser = BehaviorRelay<User?>(value: user)
    }
    
    func saveUser(_ user: User) {
        let userString = user.toJSONString()
        UserDefaults.standard.set(userString, forKey: Configs.UserDefaultsKeys.CurrentUser)
        currentUser.accept(user)
    }
    
    func removeUser() {
        UserDefaults.standard.set(nil, forKey: Configs.UserDefaultsKeys.CurrentUser)
        currentUser.accept(nil)
    }
}
