//  SettingCollectionViewCell.swift
//  QRecipes
//
//  Created by Dannyyyyyyy Zhao on 10/12/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class SettingCollectionViewCell: UICollectionViewCell {
    
    var recipe: Recipe? {
        didSet {
            imageView.sd_setImage(with: recipe?.recipeImageUrl, completed: nil)
            
            if User.shared.email != "" {
                updateExpDateLabel()
            }
        }
    }
    
    //MARK:- Properties
    let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        img.image = UIImage(named: "pasta")
        return img
    }()

    let expirationDayButton: UIButton = {
        let button = UIButton()
         
         button.backgroundColor = .white
         button.layer.cornerRadius = 10
         button.setTitle("Expiration", for: .normal)
         button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
         button.setTitleColor(.primeOrange, for: .normal)
         
         return button
    }()

    
    //MARK:- Init
    override init(frame: CGRect){
        super.init(frame: frame)
        configureCell()
        
        if User.shared.email != "" {
            configureExpDateUI()
        }
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
            make.left.right.top.bottom.equalToSuperview()
    
        }
    }
    
    private func configureExpDateUI() {
        contentView.addSubview(expirationDayButton)
        expirationDayButton.snp.makeConstraints { make in
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
            make.centerY.equalTo(imageView)
            make.width.height.equalTo(30)
        }
    }
    
    private func updateExpDateLabel() {
        var expirationDate = Date()
        let purchaseds = User.shared.purchased 
        for purchased in purchaseds {
            if purchased.key == recipe?.uid {
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                expirationDate = dateFormatter.date(from: purchased.value["expirationDate"] as? String ?? "")!
            }
        }
        let leftDays = Int(expirationDate.timeIntervalSince(Date()) / 86400)
        expirationDayButton.setTitle("\(leftDays) days", for: .normal)
    }
}
