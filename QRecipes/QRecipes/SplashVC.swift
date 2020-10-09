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

    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        setRatio()
        presentAuthenticationVC()
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

    //MARK:- Selectors
    
}

