//
//  API+Recipe.swift
//  QRecipes
//
//  Created by Mingu Choi on 10/10/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Firebase

struct newRecipe {
    let name: String
    let restaurant: String
    let level: String
    let cookTime: String
    let price: String
    let tags: [String]
    let ingrediants: [String]
    var recipeImage: UIImage
}

extension API {
    static func generateRestaurant(image: UIImage, recipes: [newRecipe], completion: @escaping(Error?, DatabaseReference?) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.3) else { return }
        let filename = NSUUID().uuidString
        let storageRef = ST_RESTAURANT_IMAGE.child(filename)
        storageRef.putData(imageData, metadata: nil) { meta, error in
            storageRef.downloadURL { url, error in
            guard let restaurantImageUrl = url?.absoluteString
            else { return }
            let values = ["name": "name",
                          "address": "address",
                          "phone": "phone",
                          "recipes": ["abc", "abc"],
                          "restaurantImageUrl": restaurantImageUrl] as [String : AnyObject]
            
            DB_RESTAURANT.childByAutoId().setValue(values, withCompletionBlock: completion)
           }
        }
    }
    
    static func uploadRecipe(recipe: newRecipe, completion: @escaping(Error?, DatabaseReference?) -> Void ) {
        guard let imageData = recipe.recipeImage.jpegData(compressionQuality: 0.3)
        else { return }

        let filename = NSUUID().uuidString
        let storageRef = ST_RECIPE_IMAGE.child(filename)
        storageRef.putData(imageData, metadata: nil) { meta, error in
            storageRef.downloadURL { (url, error) in
            guard let recipeImageUrl = url?.absoluteString else {
                return
            }
            let values = ["name": recipe.name,
                          "restaurant": recipe.restaurant,
                          "level": recipe.level,
                          "cookTime": recipe.cookTime,
                          "price": recipe.price,
                          "tags": recipe.tags,
                          "ingrediants": recipe.ingrediants,
                          "recipeImageUrl": recipeImageUrl] as [String : AnyObject]
            
            DB_RECIPE.childByAutoId().setValue(values, withCompletionBlock: completion)
           }
        }
    }
    
    static func fetchRecipes(completion: @escaping([Recipe]) -> Void) {
        
        var recipes = [Recipe]()
        
        DB_RECIPE.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String : AnyObject] else {return}
            let uid = snapshot.key
            let recipe = Recipe(uid: uid, dictionary: dictionary)
            recipes.append(recipe)
            completion(recipes)
        }
    }
    
    static func fetchFavoriteRecipes(completion: @escaping([Recipe]) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        DB_USERS.child(uid).observe(DataEventType.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let favoriteUid = value?["favorite"] as? [String] ?? [""]
            User.shared.favorite = favoriteUid
                
            var favoriteRecipes = [Recipe]()
            DB_RECIPE.observe(.childAdded) { (snapshot) in
                guard let dictionary = snapshot.value as? [String : AnyObject] else {return}
                let uid = snapshot.key
                if favoriteUid.contains(uid)
                {
                    let recipe = Recipe(uid: uid, dictionary: dictionary)
                    favoriteRecipes.append(recipe)
                }
            completion(favoriteRecipes)
            }
        })
    }
    
    static func setFavorite(recipe: Recipe, completion: @escaping(Error?, DatabaseReference?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        DB_USERS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var favorites = value?["favorite"] as? [String] ?? [""]
            let recipeUid = recipe.uid
            favorites.append(recipeUid)
            //remove duplication
            let set = Set(favorites)
            let duplicationRemovedArray = Array(set)
            let updates = ["favorite": duplicationRemovedArray]
            DB_USERS.child(uid).updateChildValues(updates, withCompletionBlock: completion)
          }) { (error) in
            print(error.localizedDescription)
        }
    }
    
    static func unsetFavorite(recipe: Recipe, completion: @escaping(Error?, DatabaseReference?) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        DB_USERS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var favorites = value?["favorite"] as? [String] ?? [""]
            let recipeUid = recipe.uid
            if let index = favorites.firstIndex(of: recipeUid) {
                favorites.remove(at: index)
            }
            let updates = ["favorite": favorites]
            DB_USERS.child(uid).updateChildValues(updates, withCompletionBlock: completion)
          }) { error in
            print(error.localizedDescription)
        }
    }
    
    static func fetchCertainRecipes(uid: [String], completion: @escaping([Recipe]) -> Void) {
        var recipes = [Recipe]()
        
        DB_RECIPE.observe(.childAdded) { (snapshot) in
            guard let dictionary = snapshot.value as? [String : AnyObject] else {return}
            let recipeUid = snapshot.key
            if uid.contains(recipeUid)
            {
                let recipe = Recipe(uid: recipeUid, dictionary: dictionary)
                recipes.append(recipe)
            }
            completion(recipes)
        }
    }
    
    static func fetchACertainRecipes(uid: String, completion: @escaping(Recipe) -> Void) {
        
        DB_RECIPE.observe(.childAdded) { (snapshot) in
            guard let dictionary = snapshot.value as? [String : AnyObject] else {return}
            let recipeUid = snapshot.key
            if uid == recipeUid
            {
                let recipe = Recipe(uid: recipeUid, dictionary: dictionary)
                completion(recipe)
            }
        }
    }
    
    static func fetchPurchasedRecipes(completion: @escaping([Recipe]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        DB_USERS.child(uid).observe(DataEventType.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let purchased = value?["purchased"] as? [String : AnyObject] ?? [:]
            User.shared.purchased = purchased // update user info when fetch
            let validUid = checkValidity(purchaseds: purchased)
            
            var purchasedRecipes = [Recipe]()
            DB_RECIPE.observe(.childAdded) { (snapshot) in
                guard let dictionary = snapshot.value as? [String : AnyObject] else {return}
                let uid = snapshot.key
                if validUid.contains(uid) {
                    let recipe = Recipe(uid: uid, dictionary: dictionary)
                    purchasedRecipes.append(recipe)
                }
                completion(purchasedRecipes)
            }
        })
    }
    
    static func checkValidity(purchaseds: [String:AnyObject]) -> [String] {
        let now = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        
        var valid = [""]
        
        if purchaseds.count > 0 {
            for purchased in purchaseds {
                if dateFormatter.date(from: purchased.value["expirationDate"] as? String ?? "") ?? now > now
                {
                    valid.append(purchased.key)
                }
            }
        }
        return valid

    }
    
    static func purhcaseRecipe(recipeUid: String, price: String, completion: @escaping(Error?, DatabaseReference?) -> Void) {
        
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        DB_USERS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            var purchased = value?["purchased"] as? [String:AnyObject] ?? [:]
            
            let now = Date().getFormattedDate(format: "yyyy-MM-dd HH:mm:ss")
            let expirationDate = Date().addingTimeInterval(7*86400).getFormattedDate(format:"yyyy-MM-dd HH:mm:ss")
            
            let transaction = ["price": price,
                               "purchaseDate": now,
            "expirationDate": expirationDate] as AnyObject
            
            purchased[recipeUid] = transaction
            
            let updates = ["purchased": purchased]
            DB_USERS.child(uid).updateChildValues(updates, withCompletionBlock: completion)
            }) { (error) in
                    print(error.localizedDescription)
                }
    }
    
    static func fetchReceipt(completion: @escaping([String:AnyObject]) -> Void) {
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        DB_USERS.child(uid).observe(DataEventType.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let purchased = value?["purchased"] as? [String : AnyObject] ?? [:]
            User.shared.purchased = purchased
            
            completion(purchased)
        })
    }
}
