//
//  ViewController.swift
//  QRecipes
//
//  Created by Kyo on 9/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class SplashVC: UIViewController, UIGestureRecognizerDelegate {
    //MARK:- Properties
    static let shared = SplashVC()
    var ratio: CGFloat = 0
    var recipes = [API.RecipeResponse]() {
        didSet {
            print("DEBUG:- \(recipes.count)")
        }
    }

    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setRatio()
        presentAuthenticationVC()
        //generateRecipe()
        API.fetchRecipes { [weak self] response in
            
            guard let strongSelf = self else {return}
            strongSelf.recipes = response
        }
    }
    
    //MARK:- Helpers
    private func presentAuthenticationVC() {
        DispatchQueue.main.async {
            let navigation = UINavigationController(rootViewController: AuthenticationVC())
            navigation.modalPresentationStyle = .fullScreen
            navigation.navigationBar.isHidden = true
            self.present(navigation, animated: false, completion: nil)
        }
    }
    
    private func setRatio() {
        let widthRatio = view.frame.width / 375.0
        let heightRatio = view.frame.height / 812.0
        SplashVC.shared.ratio = heightRatio < 1 ? 1:heightRatio
    }
    
    private func generateRecipe() {
//        let tunaSashimi = API.RecipeResponse(cookTime: "5 min",
//                                     ingrediants: ["tuna", "rice", "wassbi"],
//                                     level: "2",
//                                     name: "tuna nigiri",
//                                     price: "$6",
//                                     recipeImageUrl: "",
//                                     restaurant: "Sushi King",
//                                     tag: ["rice", "sushi", "fihs", "Japanese"])
//
//        API.uploadRecipe(recipe: tunaSashimi, image: UIImage(named: "tunaSashimi")!) { (error, ref) in
//            if let error = error {
//                print("DEBUG:- error: \(error)")
//                return
//            }
//            else {
//                print("DEBUG:- ref: \(ref)")
//            }
//        }
//
    }

    //MARK:- Selectors
    
}

