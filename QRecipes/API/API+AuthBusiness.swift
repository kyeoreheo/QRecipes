//
//  API+AuthBusiness.swift
//  QRecipes
//
//  Created by Mingu Choi on 2020/12/05.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Firebase

struct OwnerInfo {
    let email: String
    let restaurantName: String
    let phoneNumber: String
    let location: String
    var recipes: [String]
    var restaurantImageUrl: URL?
    let uid: String

    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        
        self.email = dictionary["email"] as? String ?? ""
        self.restaurantName = dictionary["restaurantName"] as? String ?? ""
        self.phoneNumber = dictionary["phoneNumber"] as? String ?? ""
        self.location = dictionary["location"] as? String ?? ""
        self.recipes = dictionary["recipes"] as? [String] ?? [""]

        if let restaurantImageUrlString = dictionary["restaurantImageUrl"] as? String {
            guard let url = URL(string: restaurantImageUrlString) else { return }
            self.restaurantImageUrl = url
        }
    }
}

struct OwnerAuthProperties {
    let email: String
    let password: String
    let restaurantName: String
    let phoneNumber: String
    let location: String
    let recipes: [String]
    let restaurantImage: UIImage
}

extension API {
    static func registerOwner(owner: OwnerAuthProperties, completion: @escaping(Error?, DatabaseReference?) -> Void ) {
        guard let imageData = owner.restaurantImage.jpegData(compressionQuality: 0.3) else { return }

        let filename = NSUUID().uuidString
        let storageRef = ST_RESTAURANT_IMAGE.child(filename)
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { url, error in
            guard let restaurantImageUrl = url?.absoluteString else { return }
            Auth.auth().createUser(withEmail: owner.email, password: owner.password) { (result, error) in
                if let error = error {
                    print("Error is \(error.localizedDescription)")
                    completion(error, nil)
                    return
                }

                guard let uid = result?.user.uid else { return }

                let values = ["email": owner.email,
                              "RestaurantName": owner.restaurantName,
                              "phoneNumber": owner.phoneNumber,
                              "location": owner.location,
                              "recipes": owner.recipes,
                              "RestaurantImageUrl": restaurantImageUrl
                             ] as [String : AnyObject]

                DB_OWNER.child(uid).updateChildValues(values, withCompletionBlock: completion)
               }
           }
        }
    }
    
    static func fetchOwner(uid: String, completion: @escaping(OwnerInfo) -> Void) {
        
        DB_OWNER.child(uid).observe(DataEventType.value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }

            let owner = OwnerInfo(uid: uid, dictionary: dictionary)
            Owner.shared.email = owner.email
            Owner.shared.restaurantName = owner.restaurantName
            Owner.shared.phoneNumber = owner.phoneNumber
            Owner.shared.restaurantImage = owner.restaurantImageUrl
            completion(owner)
            
        })
    }
    
    static func writeOwnerInfoToDB(uid: String, completion: @escaping(Error?, DatabaseReference?) -> Void ) {
        
        let values = ["email": Owner.shared.email,
                      "restaurantName": Owner.shared.restaurantName,
                      "phoneNumber": Owner.shared.phoneNumber,
                      "location": Owner.shared.location,
                      "recipes": Owner.shared.recipes,
                      "restaurantImageUrl": Owner.shared.restaurantImage?.absoluteString
                      ] as [String : AnyObject]

        DB_OWNER.child(uid).updateChildValues(values, withCompletionBlock: completion)
    }
    
}
