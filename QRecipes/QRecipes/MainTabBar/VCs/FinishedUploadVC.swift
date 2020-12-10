//
//  FinishedUploadVC.swift
//  QRecipes
//
//  Created by Yiheng Cen Feng on 12/10/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class FinishedUploadVC: UIViewController {
    //MARK:- Properties
    private let ratio = SplashVC.shared.ratio
    
    private let checkImageView = UIImageView()
    private let titleLabel = UILabel()
    private let confirmButton = UIButton()

    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    //MARK:- Helpers
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(checkImageView)
        checkImageView.image = UIImage(named: "check")
        checkImageView.contentMode = .scaleAspectFit
        checkImageView.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(titleLabel)
        titleLabel.text = "Upload\nsuccessful!"
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 40 * ratio)
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(checkImageView.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(confirmButton)
        confirmButton.setTitle("Got it!", for: .normal)
        confirmButton.backgroundColor = .primeOrange
        confirmButton.layer.cornerRadius = 10
        confirmButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18 * ratio)
        confirmButton.setTitleColor(.white, for: .normal)
        confirmButton.addTarget(self, action: #selector(dismissViewButton), for: .touchUpInside)
        confirmButton.snp.makeConstraints { make in
            make.height.equalTo(50 * ratio)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
    }

    //MARK:- Selectors
    @objc func dismissViewButton() {
        navigationController?.popToRootViewController(animated: true)
    }
    
}
