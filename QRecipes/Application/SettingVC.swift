//  SettingVC.swift
//  QRecipes

//  Created by kyo on 9/14/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit
import SDWebImage
import MessageUI
import Firebase

class SettingVC: UIViewController,UIGestureRecognizerDelegate {
    
    // MARK: - Properties
    let tableView = UITableView()
    let containerView = UIView()
    
    let columns: CGFloat = 3.0
    let inset: CGFloat = 8.0
    
    var userRecipes = [Recipe]() {
        didSet {
            collectionView.reloadData()
        }
    }

    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 15
        return view
    }()
    
    let profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "avatar")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 3
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    
    let messageButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(#imageLiteral(resourceName: "envelope").withRenderingMode(.alwaysOriginal), for: .normal)
        button.addTarget(self, action: #selector(handleEmailSupport), for: .touchUpInside)
        return button
    }()
    
    lazy var ellipsisButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        button.addTarget(self, action: #selector(presentAccountInfoVC), for: .touchUpInside)
        return button
    }()
    
    lazy var uploadButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .lightGray
        button.layer.cornerRadius = 10
        button.setTitle("Upload Recipe", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(presentUploadVC), for: .touchUpInside)
        return button
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = ""
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .white
        
        return label
    }()
    
    let emailLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = ""
        label.font = UIFont.systemFont(ofSize: 16)
        label.textColor = .white
        
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .backgroundGray
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(SettingCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    } ()

    let expirationDayButton: UIButton = {
        let button = UIButton()
        return button
    }()

    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()

        if Owner.shared.email != "" {
            configureBuisnessUI()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchUser()
        fetchUserRecipes()
    }
    
    private func configure() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureUI(){
        view.backgroundColor = .orange
        
        view.addSubview(containerView)
        containerView.snp.makeConstraints { make in
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
            make.height.equalTo(view.frame.height * 0.35)
        }
        
        view.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.height.width.equalTo(100)
            make.centerX.equalToSuperview()
            make.centerY.equalTo(containerView)
            profileImageView.layer.cornerRadius = 100 / 2
        }
        
        view.addSubview(messageButton)
        messageButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.height.width.equalTo(32)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(ellipsisButton)
        ellipsisButton.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(40)
            make.height.width.equalTo(32)
            make.right.equalToSuperview().offset(-20)
        }
        
        view.addSubview(nameLabel)
        nameLabel.snp.makeConstraints { make in
            make.top.equalTo(profileImageView.snp.bottom).offset(8)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(emailLabel)
        emailLabel.snp.makeConstraints { make in
            make.top.equalTo(nameLabel.snp.bottom).offset(2)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(emailLabel.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
        
        contentView.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(40)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    private func configureBuisnessUI(){
        contentView.addSubview(uploadButton)
        uploadButton.snp.makeConstraints { make in
            make.height.equalTo(45)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
        }
    }
    
    func fetchUser() {
        if Owner.shared.email != "" {
            if Owner.shared.restaurantImage != nil {
                profileImageView.sd_setImage(with: Owner.shared.restaurantImage, completed: nil)
            }
            nameLabel.text = Owner.shared.restaurantName
            emailLabel.text = Owner.shared.email
        } else {
            if User.shared.profileImage != nil {
                profileImageView.sd_setImage(with: User.shared.profileImage, completed: nil)
            }
            nameLabel.text = "\(User.shared.firstName) \(User.shared.lastName)"
            emailLabel.text = User.shared.email
        }
    }
    
    func fetchUserRecipes() {
        if Owner.shared.email != "" {
            API.fetchUploadedRecipes { recipes in
                self.userRecipes = recipes
            }
        } else {
            API.fetchPurchasedRecipes { recipes in
                self.userRecipes = recipes
            }
        }
    }
    
    @objc func handleEmailSupport() {
        showEmailComposer()
    }
    
    func showEmailComposer() {
        guard MFMailComposeViewController.canSendMail() else {
            let alert = UIAlertController(title: "Access Failed", message: "Mail services are not available on this device.", preferredStyle: .alert)

            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))

            self.present(alert, animated: true)
            return
        }
        
        let composer = MFMailComposeViewController()
        composer.mailComposeDelegate = self
        composer.setToRecipients(["support@qrecipes.com"])
        composer.setSubject("App Support")
        present(composer, animated: true)
    }
    
    @objc func presentAccountInfoVC() {
        let vc = AccountInfoVC() //copy
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func presentUploadVC() {
        let vc = UploadVC()
        navigationController?.pushViewController(vc, animated: true)
    }

    // Navigation
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Row \(indexPath.row)")
        let vc = RecipeDetailVC()
        vc.recipe = userRecipes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- Collection view data source
extension SettingVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return userRecipes.count
    }
    
     func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
     let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! SettingCollectionViewCell
        
        cell.recipe = userRecipes[indexPath.row]
        return cell
    }
}

//MARK:- Collection view layout
extension SettingVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / columns) - (inset*1.5)
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
}

extension SettingVC: MFMailComposeViewControllerDelegate {
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
        
        if let _ = error {
            controller.dismiss(animated: true)
            return
        }
        
        switch result {
        case .cancelled:
            print("Cancelled")
        case .failed:
            let alert = UIAlertController(title: "Email Failed to Send", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        case .saved:
            print("Saved")
        case .sent:
            let alert = UIAlertController(title: "Email Sent Successfully", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        @unknown default:
            fatalError("Unknown result")
        }
        
        controller.dismiss(animated: true)
    }
}
