//
//  API+Restaurant.swift
//  QRecipes
//
//  Created by Mingu Choi on 10/16/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Firebase

struct newRestaurant {
    let name: String
    let address: String
    let phone: String
    var recipes: [String]
    var restaurantImage: UIImage
}

struct RestaurantResponse {
    let uid: String
    let name: String
    let address: String
    let phone: String
    let recipes: [String]
    var restaurantImageUrl: URL?
    
    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.name = dictionary["name"] as? String ?? ""
        self.address = dictionary["address"] as? String ?? ""
        self.phone = dictionary["phone"] as? String ?? ""
        self.recipes = dictionary["recipes"] as? [String] ?? [""]
        
        if let restaurantImageUrl = dictionary["restaurantImageUrl"] as? String {
            guard let url = URL(string: restaurantImageUrl)
            else { return }
            self.restaurantImageUrl = url
        }
    }
}

extension API {
    static func uploadRestaurant(restaurant: newRestaurant, completion: @escaping(Error?, DatabaseReference?) -> Void ) {
        guard let imageData = restaurant.restaurantImage.jpegData(compressionQuality: 0.3)
        else { return }

        let filename = NSUUID().uuidString
        let storageRef = ST_RESTAURANT_IMAGE.child(filename)
        storageRef.putData(imageData, metadata: nil) { meta, error in
            storageRef.downloadURL { url, error in
            guard let restaurantImageUrl = url?.absoluteString
            else { return }
            let values = ["name": restaurant.name,
                          "address": restaurant.address,
                          "phone": restaurant.phone,
                          "recipes": restaurant.recipes,
                          "restaurantImageUrl": restaurantImageUrl] as [String : AnyObject]
            
            DB_RESTAURANT.childByAutoId().setValue(values, withCompletionBlock: completion)
           }
        }
    }
    
    static func fetchRestaurant(byName name: String, completion: @escaping(RestaurantResponse?) -> Void) {
        DB_RESTAURANT.observe(.childAdded) { snapshot in
            
            guard let dictionary = snapshot.value as? [String : AnyObject]
            else {return}
            
            let uid = snapshot.key
            let restaurant = RestaurantResponse(uid: uid, dictionary: dictionary)
            if restaurant.name == name {
                completion(restaurant)
            } else {
                //print("DEBUG:- input \(name) <-> snap \(restaurant.name)")
            }
        }
        //completion(nil)
    }
    
    static func fetchAllRestaurants(completion: @escaping([Restaurant]) -> Void) {
        var restaurants = [Restaurant]()
        var restauraurntRecipes = [Recipe]()
        
        DB_RESTAURANT.observe(.childAdded) { (snapshot) in
            guard let dictionary = snapshot.value as? [String : AnyObject] else {return}
            let uid = snapshot.key
            API.fetchCertainRecipes(uid: dictionary["recipes"] as! [String]) { (recipes) in
                restauraurntRecipes = recipes
            }
            
            let restaurant = Restaurant(uid: uid, recipes: restauraurntRecipes, dictionary: dictionary)
            restaurants.append(restaurant)
            completion(restaurants)
        }
    }
}
    
