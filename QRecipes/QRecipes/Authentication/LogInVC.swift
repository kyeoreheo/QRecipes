//
//  LogInView.swift
//  QRecipes
//
//  Created by Kyo on 9/29/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

struct SampleAccount {
    let email: String
    let password: String
}

class LogInVC: UIViewController, UIGestureRecognizerDelegate {
    //MARK:- Properties
    private let ratio = SplashVC.shared.ratio

    private let viewModel = AuthenticationVM()
    private let titleLabel = UILabel()
    private lazy var emailTextField = viewModel.textField(placeHolder: "Email", target: self, action: #selector(emailTextFieldDidChange), type: .email)
    private lazy var passwordTextField = viewModel.textField(placeHolder: "Password", target: self, action: #selector(passwordTextFieldDidchange), type: .password, buttonAction: #selector(toggleEyeButton))
    private let signInButton = UIButton()
    private let warningLabel = UILabel()
    private let rememberMeButton = UIButton()
    private let rememberMeLabel = UILabel()
    private let forgotPasswordButton = UIButton()
    private let bottomLabel = UILabel()
    private let facebookPlugInButton = UIButton()
    private let googlePlugInButton = UIButton()
    private let signUpLabel = UILabel()
    private let signUpButton = UIButton()
    private let centerDot = UIView()
    
    private var email = ""
    private var password = ""
    private var isPasswodHideen = true
    
    private var accounts = [SampleAccount]()
    private var keyboardHeight: CGFloat = 0.0
    private var buttonConstraint: NSLayoutConstraint?
    
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
        generateSampleAccount()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        //subscribeToShowKeyboardNotifications()
        if keyboardHeight > 0.0 {
              buttonConstraint?.constant =  20 - keyboardHeight
        }
        view.layoutIfNeeded()
        super.viewWillAppear(animated)
    }
    
    //MARK:- Helpers
    private func generateSampleAccount() {
        accounts = [SampleAccount(email: "kyo@gmail.com", password: "0000"),
                    SampleAccount(email: "yiheng@gmail.com", password: "0000"),
                    SampleAccount(email: "den@gmail.com", password: "0000"),
                    SampleAccount(email: "mingu@gmail.com", password: "0000") ]
    }
    
    private func configure() {
        view.backgroundColor = .white
        warningLabel.isHidden = true
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
            make.height.equalTo(36 * ratio)
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
        
        view.addSubview(warningLabel)
        warningLabel.textColor = .red
        warningLabel.font = UIFont.boldSystemFont(ofSize: 12)
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(30)
        }
        
        view.addSubview(signInButton)
        signInButton.backgroundColor = .lightGray
        signInButton.layer.cornerRadius = 10
        signInButton.setTitle("Log In", for: .normal)
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18 * ratio)
        signInButton.setTitleColor(.white, for: .normal)
        signInButton.addTarget(self, action: #selector(logInButton), for: .touchUpInside)
        signInButton.snp.makeConstraints { make in
            make.height.equalTo(60 * ratio)
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
        
        let crosssLine = UIView()
        view.addSubview(crosssLine)
        crosssLine.backgroundColor = .gray
        crosssLine.alpha = 0.7
        crosssLine.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.centerY.equalTo(rememberMeButton.snp.centerY)
            make.left.equalTo(rememberMeButton.snp.left)
            make.right.equalTo(rememberMeLabel.snp.right)
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
        
        let crosssLine2 = UIView()
        view.addSubview(crosssLine2)
        crosssLine2.backgroundColor = .gray
        crosssLine2.alpha = 0.7
        crosssLine2.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.centerY.equalTo(forgotPasswordButton.snp.centerY)
            make.left.equalTo(forgotPasswordButton.snp.left)
            make.right.equalTo(forgotPasswordButton.snp.right)
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
            make.right.equalTo(centerDot.snp.left).offset(-15)
        }
        
        let crosssLine3 = UIView()
        view.addSubview(crosssLine3)
        crosssLine3.backgroundColor = .gray
        crosssLine3.alpha = 0.7
        crosssLine3.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.centerY.equalTo(facebookPlugInButton.snp.centerY)
            make.left.equalTo(facebookPlugInButton.snp.left)
            make.right.equalTo(facebookPlugInButton.snp.right)
        }
        
        view.addSubview(googlePlugInButton)
        googlePlugInButton.setImage(UIImage(named: "google"), for: .normal)
        googlePlugInButton.snp.makeConstraints { make in
            make.width.height.equalTo(50)
            make.centerY.equalTo(centerDot.snp.centerY)
            make.left.equalTo(centerDot.snp.left).offset(15)
        }
        
        let crosssLine4 = UIView()
        view.addSubview(crosssLine4)
        crosssLine4.backgroundColor = .gray
        crosssLine4.alpha = 0.7
        crosssLine4.snp.makeConstraints { make in
            make.height.equalTo(2)
            make.centerY.equalTo(googlePlugInButton.snp.centerY)
            make.left.equalTo(googlePlugInButton.snp.left)
            make.right.equalTo(googlePlugInButton.snp.right)
        }
        
        view.addSubview(signUpLabel)
        signUpLabel.text = "Have no account?  Sing Up!"
        signUpLabel.textColor = .gray
        signUpLabel.font = UIFont.systemFont(ofSize: 12 * ratio)
        signUpLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
        view.addSubview(signUpButton)
        signUpButton.backgroundColor = .white
        signUpButton.addTarget(self, action: #selector(presentSignUpVC), for: .touchUpInside)
        signUpButton.setTitle("Sign Up!", for: .normal)
        signUpButton.titleLabel?.underline()
        signUpButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12 * ratio)
        signUpButton.setTitleColor(.primeOrange, for: .normal)
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
        warningLabel.isHidden = true
        if email != "" && password != "" {
            signInButton.backgroundColor = .primeOrange
        } else {
            signInButton.backgroundColor = .lightGray
        }

    }
    
    @objc func passwordTextFieldDidchange(_ textField: UITextField) {
        guard let password = textField.text else { return }
        self.password = password
        warningLabel.isHidden = true
        if email != "" && password != "" {
            signInButton.backgroundColor = .primeOrange
        } else {
            signInButton.backgroundColor = .lightGray
        }

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
    
    @objc func logInButton() {
        let lowerCaseEmail = email.lowercased()
        var hasFound = false
        
        if email != "" && password != "" {
            accounts.forEach {
                if $0.email == lowerCaseEmail && $0.password == password {
                    hasFound = true
                    DispatchQueue.main.async {
                        let navigation = UINavigationController(rootViewController: MainTabBar())
                        navigation.modalPresentationStyle = .fullScreen
                        navigation.navigationBar.isHidden = true
                        self.present(navigation, animated: false, completion: nil)
                    }
                }
            }
            if !hasFound {
                warningLabel.isHidden = false
                warningLabel.text = "Email or password is incorrect."
            }
        } else {
            warningLabel.isHidden = false
            warningLabel.text = "Type your email and password."
        }
    }
    
    @objc func presentSignUpVC() {
        navigationController?.pushViewController(SignUpVC(), animated: true)
    }

}
