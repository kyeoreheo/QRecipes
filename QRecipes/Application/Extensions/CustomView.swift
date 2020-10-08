//
//  AuthenticationVM.swift
//  QRecipes
//
//  Created by Kyo on 9/22/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class CustomView {
    ///close button on the left. height = 50
    func navigationBar(target: Any, action: Selector) -> UIView {
        let view = UIView()
        let closeButton = UIButton()
        
        view.addSubview(closeButton)
        closeButton.setImage(UIImage(named: "close"), for: .normal)
        closeButton.addTarget(target, action: action, for: .touchUpInside)
        closeButton.snp.makeConstraints { make in
            make.width.height.equalTo(30)
            make.centerY.equalToSuperview()
            make.right.equalToSuperview().offset(-20)
        }
        
        return view
    }
    
    ///warning popUp modal
    func popUpModal(message: String, buttonText: String, action: Selector, target: Any) -> UIView {
        let view = UIView()
        let coverView = UIView()
        let frameView = UIView()
        let messageLabel = UILabel()
        let button = UIButton()
        view.backgroundColor = .clear
        view.addSubview(coverView)
        coverView.backgroundColor = .black
        coverView.alpha = 0.4
        coverView.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }

        view.addSubview(frameView)
        frameView.backgroundColor = .white
        frameView.clipsToBounds = true
        frameView.layer.cornerRadius = 10
        frameView.snp.makeConstraints { make in
            make.center.equalToSuperview()
            make.width.equalTo(250)
            make.height.equalTo(250)
        }

        frameView.addSubview(messageLabel)
        messageLabel.text = message
        messageLabel.textColor = .black
        messageLabel.numberOfLines = 0
        messageLabel.textAlignment = .center
        messageLabel.font = UIFont.boldSystemFont(ofSize: 24)
        messageLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview().offset(-20)
        }

        frameView.addSubview(button)
        button.backgroundColor = .primeOrange
        button.setTitle(buttonText, for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.addTarget(target, action: action, for: .touchUpInside)
        button.snp.makeConstraints { make in
            make.height.equalTo(60)
            make.left.right.bottom.equalToSuperview()
        }
        
        return view
    }
    
    func buttonWithImage(image: UIImage, text: String, action: Selector, target: Any) -> UIButton {
        let button = UIButton()
        
        button.backgroundColor = .white
        button.layer.cornerRadius = 5
        button.setTitle(text, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.titleLabel?.textAlignment = .center
        button.imageView?.contentMode = .scaleAspectFit
        button.setImage(image, for: .normal)
        button.imageView?.snp.makeConstraints { make in
            make.height.width.equalTo(30)
            make.top.equalToSuperview().offset(5)
            make.left.equalToSuperview().offset(10)
            make.bottom.equalToSuperview().offset(-5)
        }
        button.titleLabel?.backgroundColor = .orange
        button.titleLabel?.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        button.addTarget(target, action: action, for: .touchUpInside)

        
        return button
    }
}
