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
    private let logoSize: CGFloat = 150

    private let viewModel = AuthenticationVM()
    private lazy var backgroundView = viewModel.backgroundView()
    private lazy var logoView = viewModel.logoView(logoSize: logoSize)
    private let logoTextLabel = UILabel()
    private let startButton = UIButton()
    private let creditsLabel = UILabel()

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
        view.addSubview(backgroundView)
        backgroundView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        
        view.addSubview(logoView)
        logoView.snp.makeConstraints { make in
            make.height.width.equalTo(logoSize)
            make.centerX.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(logoSize / 2)
        }
        
        view.addSubview(logoTextLabel)
        logoTextLabel.text = "Q-Recipe"
        logoTextLabel.textColor = .white
        logoTextLabel.font = UIFont.boldSystemFont(ofSize: 30)
        logoTextLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(logoView.snp.bottom).offset(30)
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
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-35)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-100)
        }
        
        view.addSubview(creditsLabel)
        creditsLabel.text = "See the Team Members"
        creditsLabel.textColor = .white
        creditsLabel.font = UIFont.systemFont(ofSize: 12)
        creditsLabel.underline()
        creditsLabel.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(presentCreditVC)))
        creditsLabel.isUserInteractionEnabled = true
        creditsLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(startButton.snp.bottom).offset(20)
        }
    }
    
    @objc func presentCreditVC() {
        DispatchQueue.main.async {
            let navigation = UINavigationController(rootViewController: CreditVC())
            navigation.modalPresentationStyle = .fullScreen
            navigation.navigationBar.isHidden = true
            self.present(navigation, animated: true, completion: nil)
        }
    }
    
    //MARK:- Selectors
    @objc func presentMainTabBar() {
        DispatchQueue.main.async {
            let navigation = UINavigationController(rootViewController: LogInVC())
            navigation.modalPresentationStyle = .fullScreen
            navigation.navigationBar.isHidden = true
            self.present(navigation, animated: false, completion: nil)
        }
    }
}
