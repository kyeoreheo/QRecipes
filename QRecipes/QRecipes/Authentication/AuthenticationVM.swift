//
//  AuthenticationVM.swift
//  QRecipes
//
//  Created by Kyo on 9/23/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

enum TextFieldType {
    case name
    case phone
    case password
    case email
}

class AuthenticationVM {
    func textField(placeHolder: String, target: Any, action: Selector, type: TextFieldType, buttonAction: Selector? = nil) -> UIView {
        let view = UIView()
        let textField = UITextField()
        let divider = UIImageView()
        let sideButton = UIButton()
        
        view.addSubview(textField)
        textField.textColor = .black
        textField.font = UIFont.boldSystemFont(ofSize: 18)
        textField.attributedPlaceholder = NSAttributedString(string: placeHolder, attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        textField.delegate = target as? UITextFieldDelegate
        textField.addTarget(target, action: action, for: .editingChanged)
        textField.autocorrectionType = .no
        textField.snp.makeConstraints { make in
            make.height.equalTo(36)
            make.top.left.right.equalToSuperview()
        }
        
        switch type {
        case .name :
            textField.keyboardType = .default
        case .phone:
            textField.keyboardType = .numberPad
        case .email:
            textField.keyboardType = .emailAddress
        case .password:
            textField.keyboardType = .default
            textField.isSecureTextEntry = true
        }
    
        view.addSubview(divider)
        divider.contentMode = .scaleAspectFit
        divider.clipsToBounds = true
        divider.isUserInteractionEnabled = true
        divider.backgroundColor = .lightlightGray
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.bottom.left.right.equalToSuperview()
        }
        
        if let buttonAction = buttonAction {
            view.addSubview(sideButton)
            sideButton.setImage(UIImage(named: "eyeOn"), for: .normal)
            sideButton.tintColor = .gray
            sideButton.imageView?.contentMode = UIView.ContentMode.scaleAspectFit
            sideButton.addTarget(target, action: buttonAction, for: .touchUpInside)
            sideButton.snp.makeConstraints { make in
                make.width.height.equalTo(20)
                make.top.equalToSuperview().offset(6)
                make.right.equalToSuperview()
            }
        }
        

        return view
    }
    
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
