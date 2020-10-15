//  SettingCollectionViewCell.swift
//  QRecipes
//
//  Created by Dannyyyyyyy Zhao on 10/12/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class SettingCollectionViewCell: UICollectionViewCell {
    
    //MARK:- Properties
    let imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        img.image = UIImage(named: "pasta")
        return img
    }()
    
    let dayExpireLabel: UILabel = {
       let label = UILabel()
       label.font = UIFont.boldSystemFont(ofSize: 14)
       label.textColor = .white
       return label
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
//            make.top.equalTo(contentView.snp.top).offset(8)
//            make.bottom.equalTo(contentView.snp.bottom).offset(-40)
//            make.left.equalTo(contentView.snp.left).offset(8)
//            make.right.equalTo(contentView.snp.right).offset(-8)
            make.left.right.top.bottom.equalToSuperview()
            //make.centerY.equalTo(imageView)
            
        }
        contentView.addSubview(dayExpireLabel)
        dayExpireLabel.snp.makeConstraints { make in
            //make.top.equalTo(imageView.snp.center).offset(10)
            make.left.equalTo(contentView).offset(20)
            make.right.equalTo(contentView).offset(-20)
            make.centerY.equalTo(imageView)
            //make.width.height.equalTo(30)
        }
        
    
    }
}
