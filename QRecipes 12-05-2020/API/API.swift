//
//  API.swift
//  QRecipes
//
//  Created by Kyo on 10/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Firebase

let DB_REF = Database.database().reference()
let DB_USERS = DB_REF.child("users")
let DB_RECIPE = DB_REF.child("recipes")
let DB_RESTAURANT = DB_REF.child("restaurants")

let ST_REF = Storage.storage().reference()
let ST_PROFILE_IMAGE = ST_REF.child("profile_image")
let ST_RECIPE_IMAGE = ST_REF.child("recipe_image")
let ST_RESTAURANT_IMAGE = ST_REF.child("restaurant_image")

class API {
    
}

