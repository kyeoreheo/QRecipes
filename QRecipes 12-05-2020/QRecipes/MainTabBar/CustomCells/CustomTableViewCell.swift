//  CustomTableViewCell.swift
//  QRecipes
//
//  Created by Dan Zhao on 10/1/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    lazy var backView: UIView = {
        let view = UIView()
        return view
    }()
    lazy var userImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    lazy var nameLbl : UILabel = {
       let lbl = UILabel()
        //lbl.textAlignment = .right
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.textColor = .black
        return lbl
    }()
    
    lazy var restaurantLbl : UILabel = {
       let lbl = UILabel()
        //lbl.textAlignment = .left
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.textColor = .orange
        return lbl
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureCell()
    }
    override func layoutSubviews() {
        backView.backgroundColor = UIColor.white
        //backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
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
        backView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        backView.addSubview(userImage)
        userImage.snp.makeConstraints { make in
            make.width.equalTo(130)
            
            make.top.equalTo(contentView.snp.top).offset(10)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.left.equalTo(contentView.snp.left).offset(10)
            //make.right.equalTo(contentView.snp.right)
        }
        backView.addSubview(nameLbl)
        nameLbl.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.top.equalTo(contentView.snp.top).offset(20)
            make.bottom.equalTo(contentView.snp.bottom).offset(-50)
            make.left.equalTo(contentView.snp.left).offset(160)
            make.right.equalTo(contentView.snp.right).offset(10)
        }
        backView.addSubview(restaurantLbl)
        restaurantLbl.snp.makeConstraints { make in
            make.width.equalTo(110)
            make.top.equalTo(contentView.snp.top).offset(70)
            make.bottom.equalTo(contentView.snp.bottom).offset(-30)
            make.left.equalTo(contentView.snp.left).offset(160)
            make.right.equalTo(contentView.snp.right).offset(10)
        }
        
    }

}
