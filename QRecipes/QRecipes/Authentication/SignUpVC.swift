//
//  SignInVC.swift
//  QRecipes
//
//  Created by Kyo on 10/5/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit
import Firebase

class SignUpVC: UIViewController, UIGestureRecognizerDelegate {
    //MARK:- Properties
    private let ratio = SplashVC.shared.ratio

    private let viewModel = AuthenticationVM()
    private let backButton = UIButton()
    private let titleLabel = UILabel()
    private lazy var firstNameTextField = viewModel.textField(placeHolder: "First name", target: self, action: #selector(firstNameTextFieldDidhange), type: .name)
    private lazy var lastNameTextField = viewModel.textField(placeHolder: "Last name", target: self, action: #selector(lastNameTextFieldDidhange), type: .name)
    private lazy var emailTextField = viewModel.textField(placeHolder: "Email", target: self, action: #selector(emailTextFieldDidChange), type: .email)
    private lazy var passwordTextField = viewModel.textField(placeHolder: "Password", target: self, action: #selector(passwordTextFieldDidchange), type: .password, buttonAction: #selector(toggleEyeButton))
    private let registerButton = UIButton()
    private let signInLabel = UILabel()
    private let signInButton = UIButton()
    private let bottomLabel = UILabel()
    private let warningLabel = UILabel()
    
    private let imagePicker = UIImagePickerController()
    private var profileImage = UIImage(named: "avatar")
    private let addPhotoButton = UIButton()
    
    private lazy var popUpModal = CustomView().popUpModal(message: "Registered!", buttonText: "Log In", action: #selector(popVC), target: self)

    private var email = ""
    private var password = ""
    private var firstName = ""
    private var lastName = ""
    private var favorite = [""]
    private var purchased:[String:AnyObject] = [:]
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
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        warningLabel.isHidden = true
        popUpModal.isHidden = true
    }
    
    private func configureUI() {
        view.addSubview(titleLabel)
        titleLabel.text = "Sign Up"
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
        
        view.addSubview(addPhotoButton)
        addPhotoButton.layer.cornerRadius = 130 / 2
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.layer.borderWidth = 2
        addPhotoButton.layer.borderColor = UIColor.gray.cgColor
        addPhotoButton.setTitle("Add Photo", for: .normal)
        addPhotoButton.setTitleColor(.black, for: .normal)
        addPhotoButton.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        addPhotoButton.snp.makeConstraints { make in
            make.width.height.equalTo(130)
            make.top.equalTo(backButton.snp.top)
            make.right.equalToSuperview().offset(-30)
        }
        
        view.addSubview(firstNameTextField)
        firstNameTextField.snp.makeConstraints { make in
            make.height.equalTo(36 * ratio)
            make.top.equalTo(addPhotoButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalTo(view.snp.centerX).offset(-15)
        }
        
        view.addSubview(lastNameTextField)
        lastNameTextField.snp.makeConstraints { make in
            make.height.equalTo(36 * ratio)
            make.top.equalTo(addPhotoButton.snp.bottom).offset(20)
            make.left.equalTo(view.snp.centerX).offset(15)
            make.right.equalToSuperview().offset(-30)
        }
        
        view.addSubview(emailTextField)
        emailTextField.snp.makeConstraints { make in
            make.height.equalTo(36 * ratio)
            make.top.equalTo(firstNameTextField.snp.bottom).offset(30)
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
        warningLabel.font = UIFont.systemFont(ofSize: 12)
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(30)
        }
        
        view.addSubview(registerButton)
        registerButton.backgroundColor = .lightGray
        registerButton.layer.cornerRadius = 10
        registerButton.setTitle("Register", for: .normal)
        registerButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18 * ratio)
        registerButton.setTitleColor(.white, for: .normal)
        registerButton.addTarget(self, action: #selector(registerUser), for: .touchUpInside)
        registerButton.snp.makeConstraints { make in
            make.height.equalTo(60 * ratio)
            make.top.equalTo(passwordTextField.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        view.addSubview(signInLabel)
        signInLabel.text = "I'm already a member, Sign In"
        signInLabel.textColor = .gray
        signInLabel.font = UIFont.systemFont(ofSize: 12 * ratio)
        signInLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
        view.addSubview(signInButton)
        signInButton.backgroundColor = .white
        signInButton.addTarget(self, action: #selector(notReadyYetButton), for: .touchUpInside)
        signInButton.setTitle("Sign In", for: .normal)
        signInButton.titleLabel?.underline()
        signInButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12 * ratio)
        signInButton.setTitleColor(.primeOrange, for: .normal)
        signInButton.addTarget(self, action: #selector(presentSingInVC), for: .touchUpInside)
        signInButton.snp.makeConstraints { make in
            make.right.equalTo(signInLabel.snp.right)
            make.centerY.equalTo(signInLabel.snp.centerY)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-50)
        }
        
        view.addSubview(popUpModal)
        popUpModal.snp.makeConstraints { make in
            make.top.left.bottom.right.equalToSuperview()
        }
        
    }
    
    func checkValidity() {
        warningLabel.isHidden = true
        if firstName != "" && lastName != "" && email != "" && password != "" {
            registerButton.backgroundColor = .primeOrange
        } else {
            registerButton.backgroundColor = .lightGray
        }
        
    }
    
    @objc func registerUser() {
        guard let profileImage = profileImage else { return }
        let lowerCaseEmail = email.lowercased()
        
        let user = AuthProperties(email: lowerCaseEmail, password: password, firstName: firstName, lastName: lastName, favorite: favorite, purchased: purchased, profileImage: profileImage)
        
        API.registerUser(user: user) { [weak self] (error, ref) in
            guard let strongSelf = self else { return }
            if let error = error {
                strongSelf.warningLabel.isHidden = false
                strongSelf.warningLabel.text = error.localizedDescription
                
            } else {
                strongSelf.popUpModal.isHidden = false
            }
        }
    }

    //MARK:- Selectors
    @objc func emailTextFieldDidChange(_ textField: UITextField) {
        guard let email = textField.text else { return }
        self.email = email
        checkValidity()

    }
    
    @objc func passwordTextFieldDidchange(_ textField: UITextField) {
        guard let password = textField.text else { return }
        self.password = password
        checkValidity()
    }
    
    @objc func firstNameTextFieldDidhange(_ textField: UITextField) {
        guard let firstName = textField.text else { return }
        self.firstName = firstName
        checkValidity()
    }
    
    @objc func lastNameTextFieldDidhange(_ textField: UITextField) {
        guard let lastName = textField.text else { return }
        self.lastName = lastName
        checkValidity()
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

    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func presentSingInVC() {
        navigationController?.pushViewController(LogInVC(), animated: true)
    }
    
    @objc func addPhoto() {
        present(imagePicker, animated: true, completion: nil)
    }

}

extension SignUpVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let profileImage = info [.editedImage] as? UIImage else { return }
        self.profileImage = profileImage
        

        addPhotoButton.imageView?.contentMode = .scaleAspectFill
        addPhotoButton.imageView?.clipsToBounds = true
        addPhotoButton.layer.borderColor = UIColor.white.cgColor
        addPhotoButton.layer.borderWidth = 3
        
        self.addPhotoButton.setImage(profileImage.withRenderingMode(.alwaysOriginal), for: .normal)
        
        dismiss(animated: true, completion: nil)
    }
}
