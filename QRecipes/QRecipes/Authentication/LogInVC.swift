//
//  LogInView.swift
//  QRecipes
//
//  Created by Kyo on 9/29/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class LogInVC: UIViewController, UIGestureRecognizerDelegate {
    //MARK:- Properties
    private let ratio = SplashVC.shared.ratio

    private let viewModel = AuthenticationVM()
    private let titleLabel = UILabel()
    private lazy var emailTextField = viewModel.textField(placeHolder: "Email", target: self, action: #selector(emailTextFieldDidChange), type: .email)
    private lazy var passwordTextField = viewModel.textField(placeHolder: "Password", target: self, action: #selector(passwordTextFieldDIdchange), type: .password, buttonAction: #selector(toggleEyeButton))
    private lazy var signInButton = UIButton()
    private lazy var rememberMeButton = UIButton()
    private let rememberMeLabel = UILabel()
    private lazy var forgotPasswordButton = UIButton()
    private let bottomLabel = UILabel()
    private lazy var facebookPlugInButton = UIButton()
    private lazy var googlePlugInButton = UIButton()
    private let signUpLabel = UILabel()
    private lazy var signUpButton = UIButton()
    private let centerDot = UIView()
    
    private var email = ""
    private var password = ""
    private var isPasswodHideen = true
    
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
        view.addSubview(titleLabel)
        titleLabel.text = "Log In"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 36 * ratio)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(50)
            make.left.equalToSuperview().offset(30)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(36 + ratio)
            make.top.equalTo(titleLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        view.addSubview(passwordTextField)
        passwordTextField.snp.makeConstraints { make in
            make.height.equalTo(36 * ratio)
            make.top.equalTo(emailTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        view.addSubview(signInButton)
        signInButton.backgroundColor = .black
        signInButton.layer.cornerRadius = 10
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18 * ratio)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(50 * ratio)
            make.top.equalTo(passwordTextField.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        view.addSubview(rememberMeButton)
        rememberMeButton.backgroundColor = .white
        rememberMeButton.layer.cornerRadius = 5
        rememberMeButton.layer.borderWidth = 1.5
        rememberMeButton.layer.borderColor = UIColor.lightlightGray.cgColor
        rememberMeButton.addTarget(self, action: #selector(notReadyYetButton), for: .touchUpInside)
        rememberMeButton.snp.makeConstraints { make in
            make.width.height.equalTo(20)
            make.top.equalTo(signInButton.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
        }
        
        view.addSubview(rememberMeLabel)
        rememberMeLabel.text = "Remember me"
        rememberMeLabel.textColor = .lightGray
        rememberMeLabel.font = UIFont.boldSystemFont(ofSize: 12 * ratio)
        rememberMeLabel.snp.makeConstraints { make in
            make.centerY.equalTo(rememberMeButton.snp.centerY)
            make.left.equalTo(rememberMeButton.snp.right).offset(10)
        }
        
        view.addSubview(forgotPasswordButton)
        forgotPasswordButton.backgroundColor = .white
        forgotPasswordButton.addTarget(self, action: #selector(notReadyYetButton), for: .touchUpInside)
        forgotPasswordButton.setTitle("Forgot password", for: .normal)
        forgotPasswordButton.titleLabel?.underline()
        forgotPasswordButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12 * ratio)
        forgotPasswordButton.setTitleColor(.lightGray, for: .normal)
        forgotPasswordButton.snp.makeConstraints { make in
            make.centerY.equalTo(rememberMeButton.snp.centerY)
            make.right.equalToSuperview().offset(-30)
        }
        
        view.addSubview(bottomLabel)
        bottomLabel.text = "or sign in with"
        bottomLabel.textColor = .gray
        bottomLabel.font = UIFont.systemFont(ofSize: 15 * ratio)
        bottomLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(rememberMeButton.snp.bottom).offset(30)
        }
        
        view.addSubview(centerDot)
        centerDot.backgroundColor = .white
        centerDot.snp.makeConstraints { make in
            make.width.height.equalTo(1)
            make.centerX.equalToSuperview()
            make.top.equalTo(bottomLabel.snp.bottom).offset(50)
        }
        
        view.addSubview(facebookPlugInButton)
        facebookPlugInButton.setImage(UIImage(named: "facebook"), for: .normal)
        facebookPlugInButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerY.equalTo(centerDot.snp.centerY)
            make.right.equalTo(centerDot.snp.left).offset(-30)
        }
        
        view.addSubview(googlePlugInButton)
        googlePlugInButton.setImage(UIImage(named: "google"), for: .normal)
        googlePlugInButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerY.equalTo(centerDot.snp.centerY)
            make.left.equalTo(centerDot.snp.left).offset(30)
        }
        
        view.addSubview(signUpLabel)
        signUpLabel.text = "Have no account?  Sing Up!"
        signUpLabel.textColor = .lightGray
        signUpLabel.font = UIFont.systemFont(ofSize: 12 * ratio)
        signUpLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
        view.addSubview(signUpButton)
        signUpButton.backgroundColor = .white
        signUpButton.addTarget(self, action: #selector(notReadyYetButton), for: .touchUpInside)
        signUpButton.setTitle("Sign Up!", for: .normal)
        signUpButton.titleLabel?.underline()
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12 * ratio)
        signUpButton.setTitleColor(.black, for: .normal)
        signUpButton.snp.makeConstraints { make in
            make.right.equalTo(signUpLabel.snp.right)
            make.centerY.equalTo(signUpLabel.snp.centerY)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
    }

    //MARK:- Selectors
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        guard let email = textField.text else { return }
        self.email = email
//        warningLabel.isHidden = true
       
//        activeButton(button: confirmButton, email != "" && password != "")
    }
    
    @objc func passwordTextFieldDIdchange(_ textField: UITextField) {
        guard let password = textField.text else { return }
        self.password = password
//        warningLabel.isHidden = true
       
//        activeButton(button: confirmButton, email != "" && password != "")
    }
    
    @objc func toggleEyeButton() {
        guard let button = passwordTextField.subviews[2] as? UIButton,
              let textField = passwordTextField.subviews[0] as? UITextField
        else { return }
        if isPasswodHideen {
            button.setImage(UIImage(named: "eyeOff"), for: .normal)
            textField.isSecureTextEntry = false
            isPasswodHideen = false
        } else {
            button.setImage(UIImage(named: "eyeOn"), for: .normal)
            textField.isSecureTextEntry = true
            isPasswodHideen = true
        }
    }
    
    @objc func notReadyYetButton() {
        print("DEBUG:- Not ready")
    }

}
