//
//  AuthenticationVC.swift
//  QRecipes
//
//  Created by Kyo on 9/14/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class AuthenticationVC: UIViewController, UIGestureRecognizerDelegate {
    //MARK:- Properties
    private let backgroundImage = UIImageView()
    private let blackCover = UIImageView()
    private let circle = UIImageView()
    private let logo = UIImageView()
    private let logoText = UILabel()
    private let startButton = UIButton()
    private let credits = UILabel()
    
// Not on our MVP
//    private let logInButton = UIButton()
//    private let signInButton = UIButton()
    
    private let logoSize: CGFloat = 150

    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
    }
    
    //MARK:- Helpers
    private func configure() {
        view.backgroundColor = .white
    }
    
    private func configureUI() {
        view.addSubview(backgroundImage)
        backgroundImage.image = UIImage(named: "authenticationView")
        backgroundImage.contentMode = .scaleAspectFill
        backgroundImage.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(blackCover)
        blackCover.backgroundColor = .black
        blackCover.alpha = 0.4
        blackCover.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        
        view.addSubview(circle)
        circle.backgroundColor = .white
        circle.layer.cornerRadius = 150 / 2
        circle.snp.makeConstraints { make in
            make.height.width.equalTo(150)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(150)
        }
        
        circle.addSubview(logo)
        logo.image = UIImage(named: "qr-code")
        logo.contentMode = .scaleAspectFit
        logo.snp.makeConstraints { make in
            make.height.width.equalTo(150 * 0.8)
            make.center.equalToSuperview()
        }
        
        view.addSubview(logoText)
        logoText.text = "Q-Recipe"
        logoText.textColor = .white
        logoText.font = UIFont.boldSystemFont(ofSize: 30)
        logoText.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logo.snp.bottom).offset(30)
        }
        
        view.addSubview(startButton)
        startButton.backgroundColor = .primeOrange
        startButton.layer.cornerRadius = 8
        startButton.setTitle("START", for: .normal)
        startButton.setTitleColor(.white, for: .normal)
        startButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 20)
        startButton.addTarget(self, action: #selector(presentMainTabBar), for: .touchUpInside)
        startButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
        view.addSubview(credits)
        credits.text = "See the Team Members"
        credits.textColor = .white
        credits.font = UIFont.systemFont(ofSize: 12)
        credits.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(startButton.snp.bottom).offset(10)
        }

    }
    
    //MARK:- Selectors
    @objc func presentMainTabBar() {
        DispatchQueue.main.async {
            let navigation = UINavigationController(rootViewController: MainTabBar())
            navigation.modalPresentationStyle = .fullScreen
            navigation.navigationBar.isHidden = true
            self.present(navigation, animated: false, completion: nil)
        }
    }
}
