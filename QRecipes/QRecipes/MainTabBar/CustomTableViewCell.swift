//
//  CustomTableViewCell.swift
//  QRecipes
//
//  Created by Dannyyyyyyy Zhao on 10/1/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    
    lazy var backView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        return view
    }()
    lazy var userImage: UIImageView = {
//        let userImage = UIImageView()
//        userImage.contentMode = .scaleAspectFill
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
    
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
//    lazy var nameLbl : UILabel = {
//       let lbl = UILabel(frame: CGRect(x: 116, y: 8, width: backView.frame.width - 116, height: 30))
//        lbl.textAlignment = .center
//        lbl.font = UIFont.boldSystemFont(ofSize: 12)
//        return lbl
//    }()
//    
//    lazy var restaurantLbl : UILabel = {
//       let lbl = UILabel(frame: CGRect(x: 116, y: 42, width: backView.frame.width - 116, height: 30))
//        lbl.textAlignment = .center
//        lbl.font = UIFont.boldSystemFont(ofSize: 12)
//        //lbl.font = UIFont.boldSystemFont(ofSize: 18)
//        return lbl
//    }()
//    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        configureCell()
    }
    override func layoutSubviews() {
        backView.backgroundColor = UIColor.clear
        backgroundColor = UIColor.clear
        backView.layer.cornerRadius = 5
        backView.clipsToBounds = true
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        contentView.addSubview(backView)
        backView.addSubview(userImage)
        //backView.addSubview(nameLbl)
        //backView.addSubview(restaurantLbl)
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
    
        backView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        userImage.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.bottom.equalTo(contentView.snp.bottom)
            make.left.equalTo(contentView.snp.left).offset(10)
            make.right.equalTo(contentView.snp.right)
        }
        
    }

}
