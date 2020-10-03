//
//  FeedCell.swift
//  QRecipes
//
//  Created by Yiheng Cen Feng on 9/27/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class FeedCell: UICollectionViewCell {
    lazy var roundedBackgroundView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 6
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 2
        view.backgroundColor = UIColor(rgb: 0xF5F5F5)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        img.image = UIImage(named: "cupcakes")
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.textColor = UIColor(rgb: 0x424242)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect){
        super.init(frame: frame)
        configureCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureCell() {
        contentView.addSubview(roundedBackgroundView)
        roundedBackgroundView.addSubview(imageView)
        roundedBackgroundView.addSubview(titleLabel)

        roundedBackgroundView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }

        imageView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top)
            make.bottom.equalTo(contentView.snp.bottom).offset(-30)
            make.left.equalTo(contentView.snp.left)
            make.right.equalTo(contentView.snp.right)
        }
        
        titleLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(imageView.snp.bottom).offset(8)
        }
    }
}
