//
//  Recipe.swift
//  QRecipes
//
//  Created by Mingu Choi on 10/10/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Foundation

struct Recipe {
    let uid: String
    let name: String
    let restaurant: String
    let level: String
    let cookTime: String
    let price: String
    let tags: [String]
    let ingredients: [String]
    var recipeImageUrl: URL?
    var comments: [Comment]
    
    struct Comment: Decodable {
        let date: String
        let text: String
        let user: String
    }

    init(uid: String, dictionary: [String: AnyObject]) {
        self.uid = uid
        self.name = dictionary["name"] as? String ?? ""
        self.restaurant = dictionary["restaurant"] as? String ?? ""
        self.level = dictionary["level"] as? String ?? ""
        self.cookTime = dictionary["cookTime"] as? String ?? ""
        self.price = dictionary["price"] as? String ?? ""
        self.tags = dictionary["tags"] as? [String] ?? [""]
        self.ingredients = dictionary["ingrediants"] as? [String] ?? [""] //typo in db
        let commentsDic = dictionary["comments"] as? [Any]
        var tempComments = [Comment]()
        commentsDic?.forEach {element in
            if let commentsDic = element as? [String : String] {
                let comment = Comment(date: commentsDic["date"] ?? "",
                                      text: commentsDic["text"] ?? "",
                                      user: commentsDic["user"] ?? "")
                tempComments.append(comment)
            }
        }
        self.comments = tempComments
        //self.comments = dictionary["comments"] as? [Comment] ?? [Comment]()
        
        if let recipeImageUrlString = dictionary["recipeImageUrl"] as? String {
            guard let url = URL(string: recipeImageUrlString) else { return }
            self.recipeImageUrl = url
        }
    }
   
}
