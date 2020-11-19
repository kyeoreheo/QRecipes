//
//  LogInView.swift
//  QRecipes
//
//  Created by Kyo on 9/29/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Firebase
import GoogleSignIn
import FBSDKLoginKit
import UIKit
import SnapKit

struct SampleAccount {
    let email: String
    let password: String
}

class LogInVC: UIViewController, UIGestureRecognizerDelegate, GIDSignInDelegate, LoginButtonDelegate {
    
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
    private let facebookPlugInButton = FBLoginButton()
    private let googlePlugInButton = GIDSignInButton()
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
        GIDSignIn.sharedInstance()?.presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self
        facebookPlugInButton.delegate = self
        
        if let token = AccessToken.current, !token.isExpired {
            //User is already logged in with facebook
            fetchFBUser(accessToken: AccessToken.current!.tokenString){ [weak self] (result) in
                guard let strongSelf = self else { return }
                print("A new user is registered")
                strongSelf.firebaseFBLogin(accessToken: AccessToken.current!.tokenString)
            }
            /*fetchFBUser(accessToken: token.tokenString)
            firebaseFBLogin(accessToken: token.tokenString)
            DispatchQueue.main.async {
                let navigation = UINavigationController(rootViewController: MainTabBar.shared)
                navigation.modalPresentationStyle = .fullScreen
                navigation.navigationBar.isHidden = true
                self.present(navigation, animated: false, completion: nil)
            }*/
        }
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        if keyboardHeight > 0.0 {
              buttonConstraint?.constant =  20 - keyboardHeight
        }
        view.layoutIfNeeded()
        super.viewWillAppear(animated)
    }
    
    //MARK:- Helpers
    private func generateSampleAccount() {
        accounts = [SampleAccount(email: "kyo@gmail.com", password: "0000"),
                    SampleAccount(email: "0", password: "0"),
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
        warningLabel.numberOfLines = 0
        warningLabel.snp.makeConstraints { make in
            make.top.equalTo(passwordTextField.snp.bottom).offset(8)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
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
            make.top.equalTo(passwordTextField.snp.bottom).offset(50)
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
        
        view.addSubview(googlePlugInButton)
        googlePlugInButton.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(bottomLabel.snp.bottom).offset(15)
            make.right.equalToSuperview().offset(-30)
            make.left.equalTo(centerDot.snp.right).offset(15)
        }
        
        let blueBackGround = UIView()
        view.addSubview(blueBackGround)
        blueBackGround.layer.cornerRadius = 2
        blueBackGround.backgroundColor = .fbColor
        blueBackGround.snp.makeConstraints { make in
            make.top.equalTo(googlePlugInButton.snp.top).offset(4)
            make.bottom.equalTo(googlePlugInButton.snp.bottom).offset(-4)
            make.left.equalToSuperview().offset(30)
            make.right.equalTo(centerDot.snp.left).offset(-15)
            make.top.equalTo(bottomLabel.snp.bottom).offset(20)
        }
        
        view.addSubview(facebookPlugInButton)
        facebookPlugInButton.backgroundColor = .fbColor
        facebookPlugInButton.snp.makeConstraints { make in
            make.centerY.equalTo(blueBackGround.snp.centerY)
            make.left.equalToSuperview().offset(30)
            make.right.equalTo(centerDot.snp.left).offset(-15)
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
        
        if email != "" && password != "" {
            API.logIn(email: lowerCaseEmail, password: password) { [weak self] (result, error) in
                guard let strongSelf = self else { return }
                if let error = error {
                    strongSelf.warningLabel.isHidden = false
                    strongSelf.warningLabel.text = error.localizedDescription
                    return
                }
                
                guard let result = result else { return }
                API.fetchUser(uid: result.user.uid) { response in
                    User.shared.email = response.email
                    User.shared.firstName = response.firstName
                    User.shared.lastName = response.lastName
                    User.shared.favorite = response.favorite
                    User.shared.purchased = response.purchased
                    User.shared.profileImage = response.profileImageUrl
                    
                    DispatchQueue.main.async {
                        let navigation = UINavigationController(rootViewController: MainTabBar.shared)
                        navigation.modalPresentationStyle = .fullScreen
                        navigation.navigationBar.isHidden = true
                        strongSelf.present(navigation, animated: false, completion: nil)
                    }
                }
            }
        }
    }
    
    @objc func presentSignUpVC() {
        navigationController?.pushViewController(SignUpVC(), animated: true)
    }
    
    func RegisterIfFirstTime(){
        guard let uid = Auth.auth().currentUser?.uid else { return }
        
        DB_USERS.child(uid).observeSingleEvent(of: .value, with: { (snapshot) in
            if snapshot.exists(){
                let value = snapshot.value as? NSDictionary
                let favorites = value?["favorite"] as? [String] ?? [""]
                let purchased = value?["purchased"] as? [String : String] ?? [:]
                User.shared.favorite = favorites
                User.shared.purchased = purchased
            }
            else{
                API.writeUserInfoToDB(uid: uid){ [weak self] (error, ref) in
                    guard self != nil else { return }
                    if error != nil {
                        print("Error: ")
                    }
                    else {
                        print("A new user is registered")
                    }
                }
            }
        })
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error?){
        if let error = error {
            print(error.localizedDescription)
            return
        }
        guard let auth = user.authentication else { return }
        let credentials = GoogleAuthProvider.credential(withIDToken: auth.idToken, accessToken: auth.accessToken)
        Auth.auth().signIn(with: credentials) { (authResult, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                print("\(user.profile.email ?? "" )  Login Successful.")
                //fetch User Info
                User.shared.email = user.profile.email
                User.shared.firstName = user.profile.givenName
                User.shared.lastName = user.profile.familyName
                if user.profile.hasImage
                {
                    let dimension = round(100 * UIScreen.main.scale)
                    User.shared.profileImage = user.profile.imageURL(withDimension: UInt(dimension))
                }
                self.RegisterIfFirstTime()
                DispatchQueue.main.async {
                    let navigation = UINavigationController(rootViewController: MainTabBar.shared)
                    navigation.modalPresentationStyle = .fullScreen
                    navigation.navigationBar.isHidden = true
                    self.present(navigation, animated: false, completion: nil)
                }
            }
        }
    }
    
    func firebaseFBLogin(accessToken: String) {
        //fetch user info from Facebook
        /*let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, first_name, last_name, picture.type(large)"],
                                                 tokenString: accessToken,
                                                 version: nil,
                                                 httpMethod: .get)
        
        request.start(completionHandler: {connection, result, error in
            let info = result as! NSDictionary
                
            User.shared.email = info["email"] as? String ?? ""
            User.shared.firstName = info["first_name"] as? String ?? ""
            User.shared.lastName = info["last_name"] as? String ?? ""
            let FBpicutre = ((info["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String
            User.shared.profileImage = URL(string: FBpicutre!)
        })*/
        
        let credential = FacebookAuthProvider.credential(withAccessToken: accessToken)
        Auth.auth().signIn(with: credential, completion: { (user, error) in
                        if (error != nil) {
                            print("Facebook authentication failed")
                        } else {
                            print("Facebook authentication succeed")
                            //chece if first time, then write user into DB
                            self.RegisterIfFirstTime()
                            DispatchQueue.main.async {
                                let navigation = UINavigationController(rootViewController: MainTabBar.shared)
                                navigation.modalPresentationStyle = .fullScreen
                                navigation.navigationBar.isHidden = true
                                self.present(navigation, animated: false, completion: nil)
                            }
                        }
        })
    }
    func fetchFBUser(accessToken: String, completion: @escaping(NSDictionary?) -> Void) {
        //fetch user info from Facebook
        let request = FBSDKLoginKit.GraphRequest(graphPath: "me",
                                                 parameters: ["fields": "email, first_name, last_name, picture.type(large)"],
                                                 tokenString: accessToken,
                                                 version: nil,
                                                 httpMethod: .get)
        
        request.start(completionHandler: {connection, result, error in
            let info = result as! NSDictionary
                
            User.shared.email = info["email"] as? String ?? ""
            User.shared.firstName = info["first_name"] as? String ?? ""
            User.shared.lastName = info["last_name"] as? String ?? ""
            let FBpicutre = ((info["picture"] as? [String: Any])?["data"] as? [String: Any])?["url"] as? String
            User.shared.profileImage = URL(string: FBpicutre!)
            completion(info)
        })
    }
    
    func loginButton(_ loginButton: FBLoginButton, didCompleteWith result: LoginManagerLoginResult?, error: Error?) {
        if let error = error {
            print("Facebook login with error: \(error.localizedDescription)")
        }
        else if ((result?.isCancelled) != nil && result?.isCancelled == true) {
            print("Facebook login cancelled")
        }
        else {
            fetchFBUser(accessToken: AccessToken.current!.tokenString){ [weak self] (result) in
                guard let strongSelf = self else { return }
                print("A new user is registered")
                strongSelf.firebaseFBLogin(accessToken: AccessToken.current!.tokenString)
            }
            print("Facebook login successed")
        }
    }
    
    func loginButtonDidLogOut(_ loginButton: FBLoginButton) {
        print("User just logged out from his Facebook account")
    }
}
