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
    lazy var commentButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .black
        button.setImage(UIImage(systemName: "message.fill"), for: .normal)
        
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
        contentView.layer.shadowColor = UIColor.lightGray.cgColor
        contentView.layer.shadowOpacity = 0.5
        contentView.layer.shadowOffset = .zero
        contentView.layer.shadowRadius = 4

        contentView.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom).offset(-40)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
        }
        
        contentView.addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.right.equalTo(contentView).offset(-10)
        }
        contentView.addSubview(commentButton)
        commentButton.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.top.equalTo(imageView.snp.bottom).offset(8)
            make.right.equalTo(favoriteButton).offset(-25)
        }
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.equalTo(contentView).offset(12)
            make.right.lessThanOrEqualTo(favoriteButton.snp.left).offset(-5)
        }
    }
    
    @objc func unsetFavorite(){
        API.unsetFavorite(recipe: recipe!) { [weak self] (error, ref) in
            guard let strongSelf = self else { return }
            if error != nil {
                print("Error: failed to unset favorite")
            } else {
                
            }
        }
    }
}
