//  CustomTableViewCell.swift
//  QRecipes
//
//  Created by Dan Zhao on 10/1/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    lazy var backView: UIView = {
        let backView = UIView()
        backView.backgroundColor = UIColor.clear
        backView.contentMode = .scaleAspectFill
        backView.layer.cornerRadius = 10
        backView.clipsToBounds = true
        return backView
    }()
    lazy var userImage: UIImageView = {
        let userImage = UIImageView()
        userImage.contentMode = .scaleAspectFill
        userImage.clipsToBounds = true
        userImage.layer.cornerRadius = 8
        userImage.translatesAutoresizingMaskIntoConstraints = false
        return userImage
    }()
    lazy var nameLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        return lbl
    }()
    
    lazy var restaurantLbl : UILabel = {
       let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        return lbl
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureCell()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCell()
    }
       
       required init?(coder: NSCoder) {
           fatalError("init(coder:) has not been implemented")
       }
    func configureCell() {
        
        contentView.addSubview(backView)
        backView.addSubview(userImage)
        backView.addSubview(nameLbl)
        backView.addSubview(restaurantLbl)
        
        backView.snp.makeConstraints { make in
            
            make.top.left.right.bottom.equalToSuperview()
        }
        userImage.snp.makeConstraints { make in
            make.width.equalTo(130)
            make.top.equalTo(contentView.snp.top).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.left.equalTo(contentView.snp.left).offset(10)
            //make.right.equalTo(contentView.snp.right)
        }
        nameLbl.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.top.equalTo(contentView.snp.top).offset(20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-50)
            make.left.equalTo(contentView.snp.left).offset(160)
            make.right.equalTo(contentView.snp.right).offset(10)
        }
        restaurantLbl.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.top.equalTo(contentView.snp.top).offset(70)
            make.bottom.equalTo(contentView.snp.bottom).offset(-30)
            make.left.equalTo(contentView.snp.left).offset(160)
            make.right.equalTo(contentView.snp.right).offset(10)
        }
        
    }

}
