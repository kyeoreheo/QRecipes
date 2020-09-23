//
//  AuthenticationVM.swift
//  QRecipes
//
//  Created by Kyo on 9/23/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class AuthenticationVM {
    func backgroundView() -> UIView {
        let view = UIView()
        let backgroundImage = UIImageView()
        let blackCover = UIImageView()
        
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
        
        return view
    }
    
    func logoView(logoSize: CGFloat) -> UIView {
        let view = UIView()
        let circle = UIImageView()
        let logo = UIImageView()
        
        view.addSubview(circle)
        circle.backgroundColor = .primeOrange
        circle.layer.cornerRadius = logoSize / 2
        circle.snp.makeConstraints { make in
            make.width.height.equalTo(logoSize)
            make.center.equalToSuperview()
        }
        
        circle.addSubview(logo)
        logo.image = UIImage(named: "qr-code")
        logo.contentMode = .scaleAspectFit
        logo.snp.makeConstraints { make in
            make.height.width.equalTo(logoSize * 0.8)
            make.center.equalToSuperview()
        }
        
        return view
    }
    
    func personInfoView(name: String, position: String, email: String) -> UIView {
        let view = UIView()
        let nameLabel = UILabel()
        let emailLabel = UILabel()
        let positionLabel = UILabel()
        
        view.addSubview(nameLabel)
        nameLabel.text = name
        nameLabel.textColor = .black
        nameLabel.font = UIFont.boldSystemFont(ofSize: 30)
        nameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(5)
        }
        
        view.addSubview(positionLabel)
        positionLabel.text = position
        positionLabel.textColor = .black
        positionLabel.font = UIFont.boldSystemFont(ofSize: 20)
        positionLabel.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(5)
            make.top.equalTo(nameLabel.snp.bottom).offset(5)
        }
        
        view.addSubview(emailLabel)
        emailLabel.text = email
        emailLabel.textColor = .black
        emailLabel.font = UIFont.systemFont(ofSize: 20)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(positionLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(5)
        }
        
        return view
    }
}
