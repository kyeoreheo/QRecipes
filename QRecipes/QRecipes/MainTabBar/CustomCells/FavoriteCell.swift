//
//  FavoriteCell.swift
//  QRecipes
//
//  Created by Yiheng Cen Feng on 10/3/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class FavoriteCell: UICollectionViewCell {
    //MARK:- Properties
    var recipe: Recipe? {
        didSet {
            imageView.sd_setImage(with: recipe?.recipeImageUrl, completed: nil)
            titleLabel.text = recipe?.name
        }
    }
    
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        img.image = UIImage(named: "cupcakes")
        return img
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = .charcoalBlack
        return label
    }()
    
    lazy var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .pumpkinRed
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        button.addTarget(self, action: #selector(unsetFavorite), for: .touchUpInside)
        return button
    }()
    
    //MARK:- Init
    override init(frame: CGRect){
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK:- Helper
    private func configureCell() {
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 6

        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(8)
            make.bottom.equalTo(contentView.snp.bottom).offset(-40)
            make.left.equalTo(contentView.snp.left).offset(8)
            make.right.equalTo(contentView.snp.right).offset(-8)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.equalTo(contentView).offset(12)
        }
        
        contentView.addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.right.equalTo(contentView).offset(-12)
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
