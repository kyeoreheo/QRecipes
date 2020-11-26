//
//  API+Auth.swift
//  QRecipes
//
//  Created by Kyo on 10/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Firebase
import FBSDKLoginKit

struct UserInfo {
    let email: String
    let firstName: String
    let lastName: String
    var favorite: [String]
    var purchased: [String:AnyObject]
    var profileImageUrl: URL?
    let uid: String

    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid

        self.email = dictionary["email"] as? String ?? ""
        self.firstName = dictionary["firstName"] as? String ?? ""
        self.lastName = dictionary["lastName"] as? String ?? ""
        self.favorite = dictionary["favorite"] as? [String] ?? [""]
        self.purchased = dictionary["purchased"] as? [String:AnyObject] ?? [:]
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
    let purchased: [String:AnyObject]
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
            User.shared.email = user.email
            User.shared.firstName = user.firstName
            User.shared.lastName = user.lastName
            User.shared.profileImage = user.profileImageUrl
            completion(user)
            
        })
    }
    
    static func writeUserInfoToDB(uid: String, completion: @escaping(Error?, DatabaseReference?) -> Void ) {
        
        let values = ["email": User.shared.email,
                      "firstName": User.shared.firstName,
                      "lastName": User.shared.lastName,
                      "favorite": User.shared.favorite,
                      "purchased": User.shared.purchased,
                      "profileImageUrl": User.shared.profileImage?.absoluteString] as [String : AnyObject]

        DB_USERS.child(uid).updateChildValues(values, withCompletionBlock: completion)
    }
    
    static func firebaseFBLogin(accessToken: String) {
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
        Auth.auth().signIn(with: credential, completion: { (user, error) in
                        if (error != nil) {
                            print("Facebook authentication failed")
                        } else {
                            print("Facebook authentication succeed")
                            //chece if first time, then write user into DB
                            registerIfFirstTime()
                        }
        })
    }
    
    static func fetchFBUser(accessToken: String, completion: @escaping(NSDictionary?) -> Void) {
        //fetch user info from Facebook
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, first_name, last_name, picture.type(large)"],
                                                 tokenString: accessToken,
                                                 version: nil,
                                                 httpMethod: .get)
        
        request.start(completionHandler: {connection, result, error in
            let info = result as! NSDictionary
                
            User.shared.email = info["email"] as? String ?? ""
            User.shared.firstName = info["first_name"] as? String ?? ""
            User.shared.lastName = info["last_name"] as? String ?? ""
            let FBpicutre = ((info["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String
            User.shared.profileImage = URL(string: FBpicutre!)
            completion(info)
        })
    }
    
    static func registerIfFirstTime(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        DB_USERS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists(){
                let value = snapshot.value as? NSDictionary
                let favorites = value?["favorite"] as? [String] ?? [""]
                let purchased = value?["purchased"] as? [String : AnyObject] ?? [:]
                User.shared.favorite = favorites
                User.shared.purchased = purchased
            }
            else{
                writeUserInfoToDB(uid: uid) {(error, ref) in
                if error != nil {
                    print("Error: ")
                }
                else {
                    print("A new user is registered")
                }
                }
            }
        })
    }
}
