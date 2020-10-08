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
    var profileImage: URL?
}
