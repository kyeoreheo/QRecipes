//
//  AccountInfoVC.swift
//  QRecipes
//
//  Created by Yiheng Cen Feng on 11/21/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit
import Firebase
import FBSDKLoginKit
import GoogleSignIn

class AccountInfoVC: UIViewController {
    //MARK:- Properties
    private let ratio = SplashVC.shared.ratio
    
    var ingredients = ["Edit Password", "Transaction History"]
    
    var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    var titleLabel: UILabel = {
       let label = UILabel()
       label.text = "Account"
       label.textColor = .black
       label.font = UIFont.boldSystemFont(ofSize: 28)
       return label
    }()
    
    var divider: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        view.alpha = 0.7
        return view
    }()
    
    var changePWButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.contentHorizontalAlignment = .left
        button.setTitle("Forgot password", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(changePW), for: .touchUpInside)
        return button
    }()
    
    var rightChevron1: UIImageView = {
        let img = UIImageView()
        img.tintColor = .black
        img.image = UIImage(systemName: "chevron.right")
        return img
    }()
    
    var divider1: UIView = {
        let view = UIView()
        view.backgroundColor = .lightlightGray
        view.alpha = 0.7
        return view
    }()
    
    var historyButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.contentHorizontalAlignment = .left
        button.setTitle("Transaction History", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        button.addTarget(self, action: #selector(presentReceiptViewVC), for: .touchUpInside)
        return button
    }()
    
    var rightChevron2: UIImageView = {
        let img = UIImageView()
        img.tintColor = .black
        img.image = UIImage(systemName: "chevron.right")
        return img
    }()
    
    var divider2: UIView = {
        let view = UIView()
        view.backgroundColor = .lightlightGray
        view.alpha = 0.7
        return view
    }()
    
    var logoutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.setTitle("Log Out", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(handleLogout), for: .touchUpInside)
        return button
    }()

    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        
        if Owner.shared.email == "" {
            configureUserUI()
        } 
    }
    
    //MARK:- Helpers
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.left.equalTo(backButton.snp.right).offset(12)
        }
        
        view.addSubview(divider)
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.right.equalToSuperview()
        }
        
        view.addSubview(changePWButton)
        changePWButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(divider.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview()
        }
        
        changePWButton.addSubview(rightChevron1)
        rightChevron1.snp.makeConstraints { make in
            make.centerY.equalTo(changePWButton.snp.centerY)
            make.right.equalTo(changePWButton.snp.right).offset(-20)
        }
        
        view.addSubview(divider1)
        divider1.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(changePWButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        view.addSubview(logoutButton)
        logoutButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
        }
    }
    
    private func configureUserUI(){
        view.addSubview(historyButton)
        historyButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(divider1.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview()
        }
        
        historyButton.addSubview(rightChevron2)
        rightChevron2.snp.makeConstraints { make in
            make.centerY.equalTo(historyButton.snp.centerY)
            make.right.equalTo(historyButton.snp.right).offset(-20)
        }
        
        view.addSubview(divider2)
        divider2.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(historyButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
    }
    
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func changePW() {
        print("Change password")
    }
    
    @objc func presentReceiptViewVC() {
        let vc = ReceiptViewVC()
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func handleLogout() {
        do {
            try Auth.auth().signOut()
            User.shared.clear()
            Owner.shared.clear()
            UserDefaults.standard.clear()
            GIDSignIn.sharedInstance().signOut()
            LoginManager().logOut()
            DispatchQueue.main.async {
                let navigation = UINavigationController(rootViewController: AuthenticationVC())
                navigation.modalPresentationStyle = .fullScreen
                navigation.navigationBar.isHidden = true
                
                self.present(navigation, animated: false)
            }
        } catch let error {
            print("------failed to sign out \(error.localizedDescription)")
        }
    }
}
