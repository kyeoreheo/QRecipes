//
//  User.swift
//  QRecipes
//
//  Created by Kyo on 10/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import Foundation

class User {
    static let shared = User()
    var email = ""
    var firstName = ""
    var lastName = ""
    var favorite = [""]
    var purchased = [String:AnyObject]()
    var profileImage: URL?
    var isBusiness = false
    
    func clear() {
        User.shared.email = ""
        User.shared.firstName = ""
        User.shared.lastName = ""
        User.shared.favorite = [""]
        User.shared.purchased = [:]
        User.shared.profileImage = nil
        User.shared.isBusiness = false
    }
}
