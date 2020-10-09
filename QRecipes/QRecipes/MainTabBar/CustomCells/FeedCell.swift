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
        }
    }
    
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
        
        contentView.addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.right.equalTo(contentView).offset(-12)
        }
    }
}
