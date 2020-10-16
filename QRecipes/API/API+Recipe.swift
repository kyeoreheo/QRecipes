//
//  API+Recipe.swift
//  QRecipes
//
//  Created by Kyo on 10/16/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Firebase

extension API {
    struct RecipeResponse {
        let cookTime: String
        let ingrediants: [String]
        let level: String
        let name: String
        let price: String
        let recipeImageUrl: String
        let restaurant: String
        let tag: [String]
    }
    
    static func uploadRecipe(recipe: RecipeResponse, image: UIImage, completion: @escaping(Error?, DatabaseReference) -> Void) {
        guard let imageData = image.jpegData(compressionQuality: 0.3) else { return }
    
        let filename = NSUUID().uuidString
        let storageRef = ST_PROFILE_IMAGE.child(filename)
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
                guard let imageUrl = url?.absoluteString else { return }
                let value = ["cookTime" : recipe.cookTime,
                             "ingrediants" : recipe.ingrediants,
                             "level" : recipe.level,
                             "name" : recipe.name,
                             "price" : recipe.price,
                             "recipeImageUrl" : imageUrl,
                             "restaurant" : recipe.restaurant,
                             "tag" : recipe.tag] as [String : Any]
                DB_POST.childByAutoId().updateChildValues(value, withCompletionBlock: completion)
            }
        }
    }
    
    static func fetchRecipes(completion: @escaping([RecipeResponse]) -> Void) {
        var recipes = [RecipeResponse]()
        
        DB_POST.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any],
                  let cookTime = dictionary["cookTime"] as? String,
                  let ingrediants = dictionary["ingrediants"] as? [String],
                  let level = dictionary["level"] as? String,
                  let name = dictionary["name"] as? String,
                  let price = dictionary["price"] as? String,
                  let recipeImageUrl = dictionary["recipeImageUrl"] as? String,
                  let restaurant = dictionary["restaurant"] as? String,
                  let tag = dictionary["tag"] as? [String]
            else { return }
            let postID = snapshot.key
            let recipe = API.RecipeResponse(cookTime: cookTime, ingrediants: ingrediants, level: level, name: name, price: price, recipeImageUrl: recipeImageUrl, restaurant: restaurant, tag: tag)
            
            recipes.append(recipe)
            completion(recipes)

        }
    }
}
