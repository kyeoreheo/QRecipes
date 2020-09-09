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
    private let sampleLable = UILabel()
    
    private let backEndButton = UIButton()
    private let frontEndButton = UIButton()
    private let teamMembersLabel = UILabel()

    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
    }
    
    //MARK:- Helpers
    private func configure() {
        view.backgroundColor = .white

        let navigationController = UINavigationController(rootViewController: self)
        UIApplication.shared.windows.first?.rootViewController = navigationController
        UIApplication.shared.windows.first?.makeKeyAndVisible()
        
        navigationController.interactivePopGestureRecognizer?.delegate = self
        navigationController.interactivePopGestureRecognizer?.isEnabled = true
        navigationController.setNavigationBarHidden(true, animated: false)
    }
    
    private func configureUI() {
        view.addSubview(sampleLable)
        sampleLable.text = "CSCI-499 capstone project"
        sampleLable.font = UIFont.systemFont(ofSize: 20)
        sampleLable.textColor = .black
        sampleLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        
        view.addSubview(backEndButton)
        backEndButton.addTarget(self, action: #selector(displayBackEndTestVC), for: .touchUpInside)
        backEndButton.setTitle("BackEnd", for: .normal)
        backEndButton.setTitleColor(.white, for: .normal)
        backEndButton.backgroundColor = .black
        backEndButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        backEndButton.layer.cornerRadius = 5
        backEndButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.right.equalTo(sampleLable.snp.centerX).offset(-20)
            make.top.equalTo(sampleLable.snp.bottom).offset(20)
        }
        
        view.addSubview(frontEndButton)
        frontEndButton.addTarget(self, action: #selector(displayFrontEndTestVC), for: .touchUpInside)
        frontEndButton.setTitle("FrontEnd", for: .normal)
        frontEndButton.setTitleColor(.white, for: .normal)
        frontEndButton.backgroundColor = .blue
        frontEndButton.titleLabel?.font = UIFont.systemFont(ofSize: 20)
        frontEndButton.layer.cornerRadius = 5
        frontEndButton.snp.makeConstraints { make in
            make.width.equalTo(150)
            make.height.equalTo(50)
            make.left.equalTo(sampleLable.snp.centerX).offset(20)
            make.top.equalTo(sampleLable.snp.bottom).offset(20)
        }
        
        view.addSubview(teamMembersLabel)
        teamMembersLabel.text = "Dan: zhaodan618@gmail.com\nYiheng: yihengcen@gmail.com\nMingu: mingu0629@gmail.com\nKyo: 91kyoheo@gmail.com"
        teamMembersLabel.numberOfLines = 0
        teamMembersLabel.font = UIFont.systemFont(ofSize: 15)
        teamMembersLabel.textColor = .black
        teamMembersLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(frontEndButton.snp.bottom).offset(8)
        }
        
    }
    
    //MARK:- Selectors
    @objc func displayBackEndTestVC() {
        print("DEBUG:- BackEndButton is clicked!")
        navigationController?.pushViewController(BackEndTestVC(), animated: true)
    }
    
    @objc func displayFrontEndTestVC() {
        print("DEBUG:- FrontEndButton is clicked!")
        navigationController?.pushViewController(FrontEndTestVC(), animated: true)
    }

}

