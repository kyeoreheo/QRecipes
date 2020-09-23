//
//  MainTabBar.swift
//  QRecipes
//
//  Created by Kyo on 9/14/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import Firebase

class MainTabBar: UITabBarController {
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()

    }
    
    // MARK: - configures
    func configureTabBar() {
        let homeTab = barTabView(view: HomeVC(), image: "home")
        let searchTab = barTabView(view: SearchVC(), image: "search")
        let middleTab = PlaceHolderVC()
        let favoriteTab = barTabView(view: FavoriteVC(), image: "favorite")
        let settingTab = barTabView(view: SettingVC(), image: "setting")
        
        viewControllers = [homeTab, searchTab, middleTab, favoriteTab, settingTab]
    }
    
    // MARK:- Helper
    func barTabView(view: UIViewController, image: String, width: CGFloat = 30, height: CGFloat = 30) -> UINavigationController {
        let tabView = UINavigationController(rootViewController: view)
        tabView.tabBarItem.image = UIImage(named: image)?.scaledDown(into: CGSize(width: width, height: height))
        tabView.navigationBar.isHidden = true
        return tabView
    }
    
}
