//
//  FeedCell.swift
//  QRecipes
//
//  Created by Yiheng Cen Feng on 9/27/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SDWebImage

class FeedCell: UICollectionViewCell {
    //MARK:- Properties
    var recipe: Recipe? {
        didSet {
            imageView.sd_setImage(with: recipe?.recipeImageUrl, completed: nil)
            restaurantLabel.text = recipe?.restaurant
            recipeLabel.text = recipe?.name
            isFavorite()
            
        }
    }
    
    var favIsOn = false
    
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.image = UIImage(named: "cupcakes")
        return img
    }()
    
    lazy var restaurantLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.textColor = .black
        return label
    }()
    
    lazy var recipeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .gray
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .primeOrange
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    lazy var commentButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .primeOrange
        //button.backgroundColor = UIColor.orange
        button.setImage(UIImage(systemName: "message"), for: .normal)
        button.addTarget(self, action: #selector(isTapCommentButton), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.left.right.top.equalToSuperview()
            make.bottom.equalTo(contentView.snp.bottom).offset(-60)
        }
        
        contentView.addSubview(restaurantLabel)
        restaurantLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.equalTo(contentView).offset(10)
        }
        
        contentView.addSubview(recipeLabel)
        recipeLabel.snp.makeConstraints { make in
            make.top.equalTo(restaurantLabel.snp.bottom)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalTo(contentView).offset(12)
        }
        
        if User.shared.email == "" {
            favoriteButton.isHidden = true
            commentButton.isHidden = true
        } else {
            favoriteButton.isHidden = false
            commentButton.isHidden = false
            contentView.addSubview(favoriteButton)
            favoriteButton.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.bottom).offset(10)
                make.right.equalTo(contentView).offset(-12)
            }
            contentView.addSubview(commentButton)
            commentButton.snp.makeConstraints { make in
                make.top.equalTo(imageView.snp.bottom).offset(10)
                make.left.equalTo(favoriteButton).offset(-30)
            }
        }

        
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
    @objc func isTapCommentButton() {
        
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


