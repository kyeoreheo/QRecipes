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
let DB_POST = DB_REF.child("posts")

let ST_REF = Storage.storage().reference()
let ST_PROFILE_IMAGE = ST_REF.child("profile_image")

class API {
    
}

