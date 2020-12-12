//
//  CommentCell.swift
//  QRecipes
//
//  Created by Dannyyyyyyy Zhao on 12/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SDWebImage

class CommentCell: UITableViewCell {
    //MARK:- Properties
    
    private let ratio = SplashVC.shared.ratio
    var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "profile")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 3
        iv.layer.cornerRadius = 25
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Danny"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13 * ratio, weight: UIFont.Weight.bold)
        
        return label
    }()
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        //label.text = "Love it, it is easy to follow.Thank you. :)"
        label.textColor = .black
        label.font = UIFont(name:"Helvetica", size: 14 * ratio)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }()
    lazy var thumbsUpButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .primeOrange
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        
        return button
    }()
    lazy var thumbsDownButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .primeOrange
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
        
        return button
    }()
    
    var userUID = "" {
        didSet {
            API.fetchUser(uid: userUID, updateUser: false) { response in
                self.userNameLabel.text = response.firstName + " " + response.lastName
                self.profileImageView.sd_setImage(with: response.profileImageUrl, completed: nil)
            }
        }
    }
    
    let timeLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        contentView.backgroundColor = .white
        
        contentView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(50 * ratio)
            make.top.left.equalToSuperview().offset(4)
        }
        contentView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.left.equalTo(profileImageView.snp.right).offset(8)
            
        }
        contentView.addSubview(commentLabel)
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel.snp.bottom).offset(4)
            make.left.equalTo(profileImageView.snp.right).offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        
        contentView.addSubview(timeLabel)
        timeLabel.textColor = .gray
        timeLabel.textAlignment = .right
        timeLabel.font = UIFont.systemFont(ofSize: 12 * ratio)
        timeLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(4)
            make.right.equalToSuperview().offset(-4)
        }

    }
    
}
