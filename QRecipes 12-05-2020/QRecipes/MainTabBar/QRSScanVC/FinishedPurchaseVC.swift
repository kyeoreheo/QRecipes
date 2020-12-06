//
//  FinishedPurchaseVC.swift
//  QRecipes
//
//  Created by Kyo on 10/15/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class FinishedPurchaseVC: UIViewController {
    //MARK:- Properties
    private let ratio = SplashVC.shared.ratio
    
    private let checkImageView = UIImageView()
    private let titleLabel = UILabel()
    private let bodyLabel = UILabel()
    private let confirmButton = UIButton()

    private let itemName: String
    
    //MARK:- LifeCycles
    init(itemName: String) {
        self.itemName = itemName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        
        view.addSubview(checkImageView)
        checkImageView.image = UIImage(named: "check")
        checkImageView.contentMode = .scaleAspectFit
        checkImageView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(titleLabel)
        titleLabel.text = "Purchase\nsuccessful!"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40 * ratio)
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(checkImageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(bodyLabel)
        bodyLabel.text = "Thank you for purchasing \(itemName).\n\nYou can find it in the [Setting Tabs]"
        bodyLabel.numberOfLines = 0
        bodyLabel.textAlignment = .center
        bodyLabel.font = UIFont.boldSystemFont(ofSize: 18 * ratio)
        bodyLabel.textColor = .darkGray
        bodyLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
            make.left.equalTo(view).offset(20)
            make.right.equalTo(view).offset(-20)
        }
        
        view.addSubview(confirmButton)
        confirmButton.setTitle("Got it!", for: .normal)
        confirmButton.backgroundColor = .primeOrange
        confirmButton.layer.cornerRadius = 10
        confirmButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18 * ratio)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.addTarget(self, action: #selector(dismissViewButton), for: .touchUpInside)
        confirmButton.snp.makeConstraints { make in
            make.height.equalTo(60 * ratio)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
    }

    //MARK:- Selectors
    @objc func dismissViewButton() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
