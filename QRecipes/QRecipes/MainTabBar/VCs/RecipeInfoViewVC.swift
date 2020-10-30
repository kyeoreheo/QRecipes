//
//  RecipeInfoViewVC.swift
//  QRecipes
//
//  Created by Dan Zhao on 10/19/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class RecipeInfoViewVC: UIViewController {
    
    //MARK:- Properties
    var recipe: Recipe? {
        didSet {
            recipeImageView.sd_setImage(with: recipe?.recipeImageUrl, completed: nil)
            restaurantLabel.text = recipe?.restaurant
            titleLabel.text = recipe?.name
            cookTimeLabel.text = "Cook Time: " + recipe!.cookTime
            cookDifficultyLabel.text = "Difficulty: " + recipe!.level
        }
    }

    var favIsOn = false
  
    private let ratio = SplashVC.shared.ratio
    
    var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    var restarantImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.image = UIImage(named: "pasta-restaurant")
        return img
    }()
    
    var infoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4
        return view
    }()
    
    var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .backgroundGray
        button.alpha = 0.9
        button.layer.cornerRadius = 20
        button.tintColor = .primeOrange
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    var purchaseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .primeOrange
        button.layer.cornerRadius = 10
        button.setTitle("Purchase", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(pressPurchaseButton), for: .touchUpInside)
        return button
    }()
    
    var locationIcon: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .gray
        button.setImage(UIImage(systemName: "location"), for: .normal)
        return button
    }()
    
    var phoneIcon: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .gray
        button.setImage(UIImage(systemName: "phone"), for: .normal)
        return button
    }()
    
    var restaurantLabel: UILabel = {
        let label = UILabel()
        label.text = "La Pasta"
        label.textColor = .black
        label.font = UIFont(name:"Helvetica", size: 22)
        label.numberOfLines = 0
        return label
    }()

    var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "13 St Marks Pl, New York, NY 10003"
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "347-876-5746"
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recipe's Detail"
        label.textColor = .charcoalBlack
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    var cookTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Cook Time: 30 mins"
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = NSTextAlignment.center
        //label.textAlignment = .center
        return label
    }()
    
    var cookDifficultyLabel: UILabel = {
        let label = UILabel()
        label.text = "Difficulty: Easy"
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    var spicyLevelLabel: UILabel = {
        let label = UILabel()
        label.text = "Spicy Level: Medium spicy"
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.textAlignment = .center
        return label
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4
        return view
    }()
    
    var recipeImageView: UIImageView = {
        let rimg = UIImageView()
        rimg.contentMode = .scaleAspectFill
        rimg.clipsToBounds = true
        rimg.layer.cornerRadius = 8
        rimg.backgroundColor = .white
        rimg.layer.shadowColor = UIColor.lightGray.cgColor
        rimg.layer.shadowOpacity = 0.5
        rimg.layer.shadowOffset = .zero
        rimg.layer.shadowRadius = 4
        rimg.isUserInteractionEnabled = true
        return rimg
    }()
    
    private let isInPurchaseFlow: Bool
    
    //MARK:- LifeCycles
    init(isInPurchaseFlow: Bool = false) {
        self.isInPurchaseFlow = isInPurchaseFlow
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isFavorite()
        super.viewDidAppear(animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchRestaurant()
    }
    
    //MARK:- Helpers
    private func configureUI() {
        view.backgroundColor = .backgroundGray
        
        view.addSubview(restarantImageView)
        restarantImageView.snp.makeConstraints { make in
            make.height.equalTo(view.frame.height*0.4)
            make.left.right.top.equalToSuperview()
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        view.addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.size.equalTo(150)
            if isInPurchaseFlow {
                make.top.equalTo(backButton.snp.bottom).offset(10)
            } else {
                make.top.equalTo(restarantImageView.snp.bottom).offset(-95)
            }
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        infoView.addSubview(restaurantLabel)
        restaurantLabel.snp.makeConstraints { make in
            make.top.equalTo(infoView).offset(20)
            make.left.equalTo(infoView).offset(20)
            //make.right.equalTo(favoriteButton.snp.left)
        }
        
        infoView.addSubview(locationIcon)
        locationIcon.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(restaurantLabel.snp.bottom).offset(15)
            make.left.equalTo(infoView).offset(20)
        }
        
        infoView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(restaurantLabel.snp.bottom).offset(15)
            make.left.equalTo(locationIcon.snp.right).offset(10)
            make.right.equalTo(infoView).offset(-20)
        }
        
        infoView.addSubview(phoneIcon)
        phoneIcon.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(locationLabel.snp.bottom)
            make.left.equalTo(infoView).offset(20)
        }
        
        infoView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(locationLabel.snp.bottom)
            make.left.equalTo(phoneIcon.snp.right).offset(10)
            make.right.equalTo(infoView).offset(-20)
        }
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.size.equalTo(view.frame.height*0.4)
            make.top.equalTo(infoView.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(infoView).offset(10)
        }
        
        contentView.addSubview(recipeImageView)
        recipeImageView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
            make.height.equalTo(150)
        }
        
        recipeImageView.addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.bottom.equalTo(recipeImageView.snp.bottom).offset(-10)
            make.right.equalTo(recipeImageView).offset(-10)
        }
        
        contentView.addSubview(cookTimeLabel)
        cookTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(15)
            make.left.equalTo(contentView).offset(30)
            make.right.equalTo(contentView).offset(-30)
        }
        contentView.addSubview(cookDifficultyLabel)
        cookDifficultyLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(40)
            make.left.equalTo(contentView).offset(30)
            make.right.equalTo(contentView).offset(-30)
        }
        contentView.addSubview(spicyLevelLabel)
        spicyLevelLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(65)
            make.left.equalTo(contentView).offset(30)
            make.right.equalTo(contentView).offset(-30)
        }
        
        view.addSubview(purchaseButton)
        purchaseButton.snp.makeConstraints { make in
            make.height.equalTo(45 * ratio)
            make.bottom.equalTo(contentView).offset(-20)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
        }
    }
    
    private func fetchRestaurant() {
        guard let recipe = recipe else { return }
        API.fetchRestaurant(byName: recipe.restaurant) { [weak self] response in
            guard let strongSelf = self,
                  let url = response?.restaurantImageUrl
            else { return }
            strongSelf.restarantImageView.sd_setImage(with: url)
        }
    }
    
    //MARK:- Selectors
    @objc func pressPurchaseButton() {
        guard let restaurantName = recipe?.name,
              let payAmount = recipe?.price,
              let uid = recipe?.uid
        else { return }
        
        let vc = PurchaseVC(itemName: restaurantName, payAmount: payAmount, uid: uid)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func buttonPressed() {
        favIsOn = !favIsOn
        if favIsOn {
            setFavorite()
        }
        else {
            unsetFavorite()
        }
    }
    
    func isFavorite() -> Void {
        let favoriteUid = User.shared.favorite
        guard let uid = recipe?.uid else { return }
        if favoriteUid.contains(uid) {
            favIsOn = true
            self.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else {
            favIsOn = false
            self.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @objc func setFavorite(){
        API.setFavorite(recipe: recipe!) { [weak self] (error, ref) in
            guard let strongSelf = self else { return }
            if error != nil {
                print("Error: failed to set favorite")
            } else {
                strongSelf.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
    }
    
    @objc func unsetFavorite(){
        API.unsetFavorite(recipe: recipe!) { [weak self] (error, ref) in
            guard let strongSelf = self else { return }
            if error != nil {
                print("Error: failed to unset favorite")
            } else {
                strongSelf.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
}


