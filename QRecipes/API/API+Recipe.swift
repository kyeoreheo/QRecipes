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
    
    static func uploadRecipe(recipe: newRecipe, completion: @escaping(Error?, DatabaseReference?) -> Void ) {
        guard let imageData = recipe.recipeImage.jpegData(compressionQuality: 0.3) else { return }

        let filename = NSUUID().uuidString
        let storageRef = ST_RECIPE_IMAGE.child(filename)
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
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
        
        DB_RECIPE.observe(.childAdded) { (snapshot) in
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
                
            var favoriteRecipes = [Recipe]()
            if favoriteUid.count != 1 {
                DB_RECIPE.observe(.childAdded) { (snapshot) in
                    guard let dictionary = snapshot.value as? [String : AnyObject] else {return}
                    let uid = snapshot.key
                    if favoriteUid.contains(uid)
                    {
                        let recipe = Recipe(uid: uid, dictionary: dictionary)
                        favoriteRecipes.append(recipe)
                        completion(favoriteRecipes)
                    }
                }
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
    
    /*static func isFavorite(recipe: Recipe, completion: @escaping(Error?, DatabaseReference?) -> Void) {
        var favorite = true
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        DB_USERS.child(uid).observe(DataEventType.value, with: { (snapshot) in
            let value = snapshot.value as? NSDictionary
            let favoriteUid = value?["favorite"] as? [String] ?? [""]
           
            let uid = recipe.uid
            if favoriteUid.contains(uid) {
                return favorite
            }
            else {
                fa
            }
        })
    }*/
}
