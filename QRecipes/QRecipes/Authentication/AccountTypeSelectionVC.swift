//
//  AccountTypeSelectionVC.swift
//  QRecipes
//
//  Created by Mingu Choi on 2020/12/05.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class AccountTypeSelectionVC: UIViewController {
    
    //MARK:- Properties
    private let ratio = SplashVC.shared.ratio
    
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    
    let customuerButton = UIButton()
    let ownerButton = UIButton()
    
    // MARK: - Lifecycle
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
        view.addSubview(titleLabel)
        titleLabel.text = "Account Type"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36 * ratio)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.left.equalToSuperview().offset(30)
        }
        
        view.addSubview(backButton)
        backButton.backgroundColor = .clear
        backButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        backButton.setImage(UIImage(named: "arrow-left"), for: .normal)
        backButton.contentMode = .scaleAspectFit
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(customuerButton)
        customuerButton.backgroundColor = .lightGray
        customuerButton.layer.cornerRadius = 10
        customuerButton.setTitle("I'm a customer", for: .normal)
        customuerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18 * ratio)
        customuerButton.setTitleColor(.white, for: .normal)
        customuerButton.addTarget(self, action: #selector(presentCustomerSingUp), for: .touchUpInside)
        customuerButton.snp.makeConstraints { make in
            make.height.equalTo(60 * ratio)
            make.centerY.equalToSuperview().offset(45 * ratio)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        view.addSubview(ownerButton)
        ownerButton.backgroundColor = .lightGray
        ownerButton.layer.cornerRadius = 10
        ownerButton.setTitle("I'm a restaurant owner", for: .normal)
        ownerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18 * ratio)
        ownerButton.setTitleColor(.white, for: .normal)
        ownerButton.addTarget(self, action: #selector(presentOwnerSingUp), for: .touchUpInside)
        ownerButton.snp.makeConstraints { make in
            make.height.equalTo(60 * ratio)
            make.centerY.equalToSuperview().offset(-45 * ratio)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
    }
    
    //MARK:- Selectors
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func presentCustomerSingUp() {
        navigationController?.pushViewController(SignUpVC(), animated: true)
    }
    
    @objc func presentOwnerSingUp() {
        navigationController?.pushViewController(BusinessSignUpVC(), animated: true)
    }
}
