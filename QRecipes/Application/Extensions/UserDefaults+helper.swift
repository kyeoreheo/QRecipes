//
//  UserDefaults+helper.swift
//  QRecipes
//
//  Created by Mingu Choi on 11/19/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Foundation

extension UserDefaults {
    
    enum UserDefaultsKeys: String {
        case isLoggedIn
        case email
        case password
    }
    func setIsLoggedIn(value: Bool) {
        set(value, forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        synchronize()
    }
    func isLoggedIn() -> Bool {
        return bool(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
    }
    
    func setEmail(value: String) {
        set(value, forKey: UserDefaultsKeys.email.rawValue)
        synchronize()
    }
    func getEmail() -> String {
        return UserDefaults.standard.value(forKey: UserDefaultsKeys.email.rawValue) as! String
    }
    
    func setPassword(value: String) {
        set(value, forKey: UserDefaultsKeys.password.rawValue)
        synchronize()
    }
    func getPassword() -> String {
        return UserDefaults.standard.value(forKey: UserDefaultsKeys.password.rawValue) as! String
    }
    
    func clear() -> Void {
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.isLoggedIn.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.email.rawValue)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.password.rawValue)
    }
}
