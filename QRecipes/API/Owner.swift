//
//  Owner.swift
//  QRecipes
//
//  Created by Mingu Choi on 2020/12/05.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Foundation

class Owner {
    static let shared = Owner()
    var email = ""
    var restaurantName = ""
    var phoneNumber = ""
    var location = ""
    var recipes = [""]
    var restaurantImage: URL?
    var isBusiness = true
    
    func clear() {
        Owner.shared.email = ""
        Owner.shared.restaurantName = ""
        Owner.shared.phoneNumber = ""
        Owner.shared.location = ""
        Owner.shared.recipes = [""]
        Owner.shared.restaurantImage = nil
    }
}
