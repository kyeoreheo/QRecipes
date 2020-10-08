//
//  API+Auth.swift
//  QRecipes
//
//  Created by Kyo on 10/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Firebase

struct AuthProperties {
    let email: String
    let password: String
    let firstName: String
    let lastName: String
    let profileImage: UIImage
}

extension API {
    static func registerUser(user: AuthProperties, completion: @escaping(Error?, DatabaseReference?) -> Void ) {
        guard let imageData = user.profileImage.jpegData(compressionQuality: 0.3) else { return }

        let filename = NSUUID().uuidString
        let storageRef = ST_PROFILE_IMAGE.child(filename)
        storageRef.putData(imageData, metadata: nil) { (meta, error) in
            storageRef.downloadURL { (url, error) in
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
                                  "profileImageUrl": profileImageUrl]

                    DB_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
               }
           }
        }
    }
}
