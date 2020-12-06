//
//  Restaurant.swift
//  QRecipes
//
//  Created by Mingu Choi on 10/16/20.
//  Copyright © 2020 Kyo. All rights reserved.
//
import Foundation

struct Restaurant {
    
    let uid: String
    let name: String
    let address: String
    let phone: String
    let recipes: [Recipe]
    var restaurantImageUrl: URL?

    init(uid: String, recipes: [Recipe], dictionary: [String: AnyObject]) {
        self.uid = uid
        self.recipes = recipes
        
        self.name = dictionary["name"] as? String ?? ""
        self.address = dictionary["address"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
        
        if let restaurantImageUrlString = dictionary["restaurantImageUrl"] as? String {
            guard let url = URL(string: restaurantImageUrlString) else { return }
            self.restaurantImageUrl = url
        }
    }
   
}
