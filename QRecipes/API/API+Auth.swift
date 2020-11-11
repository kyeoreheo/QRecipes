//
//  API+Auth.swift
//  QRecipes
//
//  Created by Kyo on 10/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Firebase

struct UserInfo {
    let email: String
    let firstName: String
    let lastName: String
    var favorite: [String]
    var purchased: [String:String]
    var profileImageUrl: URL?
    let uid: String

    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid

        self.email = dictionary["email"] as? String ?? ""
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.favorite = dictionary["favorite"] as? [String] ?? [""]
        self.purchased = dictionary["purchased"] as? [String:String] ?? [:]
        if let profileImageUrlString = dictionary["profileImageUrl"] as? String {
            guard let url = URL(string: profileImageUrlString) else { return }
            self.profileImageUrl = url
        }
    }
}

struct AuthProperties {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let favorite: [String]
    let purchased: [String:String]
    let profileImage: UIImage
}

extension API {
    static func logIn(email: String, password: String, completion: AuthDataResultCallback?) {
        Auth.auth().signIn(withEmail: email, password: password, completion: completion)
    }
    
    static func registerUser(user: AuthProperties, completion: @escaping(Error?, DatabaseReference?) -> Void ) {
        guard let imageData = user.profileImage.jpegData(compressionQuality: 0.3) else { return }

        let filename = NSUUID().uuidString
        let storageRef = ST_PROFILE_IMAGE.child(filename)
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { url, error in
            guard let profileImageUrl = url?.absoluteString else { return }
            Auth.auth().createUser(withEmail: user.email, password: user.password) { (result, error) in
                if let error = error {
                    print("Error is \(error.localizedDescription)")
                    completion(error, nil)
                    return
                }

                guard let uid = result?.user.uid else { return }

                let values = ["email": user.email,
                              "firstName": user.firstName,
                              "lastName": user.lastName,
                              "favorite": user.favorite,
                              "purchased": user.purchased,
                              "profileImageUrl": profileImageUrl] as [String : AnyObject]

                DB_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
               }
           }
        }
    }
    
    static func fetchUser(uid: String, completion: @escaping(UserInfo) -> Void) {
        
        DB_USERS.child(uid).observe(DataEventType.value, with: { (snapshot) in
            guard let dictionary = snapshot.value as? [String: AnyObject] else { return }

            let user = UserInfo(uid: uid, dictionary: dictionary)
            completion(user)
            
        })
    }
}
