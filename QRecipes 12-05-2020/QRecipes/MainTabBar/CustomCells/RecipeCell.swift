//
//  RecipeCell.swift
//  QRecipes
//
//  Created by Yiheng Cen Feng on 10/13/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit



class RecipeCell: UITableViewCell {
    //MARK:- Properties
    private let ratio = SplashVC.shared.ratio

    var recipeImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        img.image = UIImage(named: "pasta")
        return img
    }()

    var recipeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .white
        return label
    }()
    
    private let purchaseButton = UIButton()
    public let payAmountLabel = UIButton()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCell()
    }
          
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(recipeImage)
        recipeImage.snp.makeConstraints { make in
            make.left.top.equalToSuperview().offset(10)
            make.right.bottom.equalToSuperview().offset(-10)
        }
    
        contentView.addSubview(recipeLabel)
        recipeLabel.snp.makeConstraints { make in
            make.bottom.equalTo(recipeImage).offset(-10)
            make.right.equalTo(recipeImage).offset(-10)
        }
    }
    
    func showPurchaseUI() {
        recipeImage.addSubview(purchaseButton)
        purchaseButton.setTitle("Purchase", for: .normal)
        purchaseButton.backgroundColor = .primeOrange
        purchaseButton.layer.cornerRadius = 10
        purchaseButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12 * ratio)
        purchaseButton.setTitleColor(.white, for: .normal)
        purchaseButton.addTarget(self, action: #selector(presentPurchaseVC), for: .touchUpInside)
        purchaseButton.snp.makeConstraints { make in
            make.height.equalTo(30 * ratio)
            make.width.equalTo(80 * ratio)
            make.bottom.equalToSuperview().offset(-10)
            make.left.equalToSuperview().offset(10)
        }
        
        recipeImage.addSubview(payAmountLabel)
        //payAmountLabel.setTitle("$12", for: .normal)
        payAmountLabel.backgroundColor = .primeOrange
        payAmountLabel.layer.cornerRadius = 10
        payAmountLabel.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15 * ratio)
        payAmountLabel.setTitleColor(.white, for: .normal)
        payAmountLabel.isUserInteractionEnabled = false
        payAmountLabel.snp.makeConstraints { make in
            make.width.height.equalTo(30 * ratio)
            make.top.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
        }
    }
    
    @objc func presentPurchaseVC() {
        
    }
}
