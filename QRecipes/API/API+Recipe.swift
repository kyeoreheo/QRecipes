//
//  API+Recipe.swift
//  QRecipes
//
//  Created by Mingu Choi on 10/10/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Firebase

struct RecipeInfo {
    let name: String
    let restaurant: String
    let level: String
    let cookTime: String
    let price: String
    let tags: [String]
    let ingrediants: [String]
    var recipeImageUrl: URL?

    init(dictionary: [String: Any]) {
        
        self.name = dictionary["name"] as? String ?? ""
        self.restaurant = dictionary["restaurant"] as? String ?? ""
        self.level = dictionary["level"] as? String ?? ""
        self.cookTime = dictionary["cookTime"] as? String ?? ""
        self.price = dictionary["price"] as? String ?? ""
        self.tags = dictionary["tags"] as? [String] ?? [""]
        self.ingrediants = dictionary["ingrediants"] as? [String] ?? [""]
        
        if let recipeImageUrlString = dictionary["recipeImageUrl"] as? String {
            guard let url = URL(string: recipeImageUrlString) else { return }
            self.recipeImageUrl = url
        }
    }
}

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
                              "recipeImageUrl": recipeImageUrl] as [String : Any]
                
                DB_RECIPE.childByAutoId().setValue(values, withCompletionBlock: completion)
           }
        }
    }
    
    static func fetchRecipes(completion: @escaping(RecipeInfo) -> Void) {
        var recipes = [RecipeInfo]()
        DB_RECIPE.observe(.childAdded) { (snapshot) in
            let dictionary = snapshot.value as? [String : Any] ?? ["":""]
            let recipe = RecipeInfo(dictionary: dictionary)
            recipes.append(recipe)
            
        }
    }
    
    /*func fetchRecipe(completion: @escaping([Recipe]) -> Void) {
        var posts = [Post]()
        
        DB_RECIPE.observe(.childAdded) { snapshot in
            guard let dictionary = snapshot.value as? [String: Any],
                  let uid = dictionary ["uid"] as? String
                else { return }
            let postID = snapshot.key
            
            UserService.shared.fetchUser(uid: uid) { user in
                let post = Post(user: user, postID: postID, dictionary: dictionary)
                posts.append(post)
                completion(posts)
            }
        }
    }*/
}
/*class API {
    
    public typealias uploadPictureCompletion = (Result<String, Error>) -> Void
    public func uploadRecipePicture(with data: Data, filename: String, completion: @escaping uploadPictureCompletion) {
        
        ST_RECIPE_IMAGE.child(filename).putData(data, metadata: nil, completion: {metadata, error in
            guard error == nil else {
                print("Failed to upload")
                return
            }
            
            ST_RECIPE_IMAGE.child(filename).downloadURL(completion: { url, error in
                guard url == url else {
                    print("failed to get download url")
                    return
                }
                
                let urlString = url!.absoluteString
                
            })
        })
    }
}*/
