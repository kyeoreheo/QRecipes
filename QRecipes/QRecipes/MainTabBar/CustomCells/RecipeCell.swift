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
}
