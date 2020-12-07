//
//  TransanctionCell.swift
//  QRecipes
//
//  Created by Mingu Choi on 11/26/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SDWebImage

class TransactionCell: UITableViewCell {
    //MARK:- Properties
    var recipeUid: String? {
        didSet {
            API.fetchACertainRecipes(uid: recipeUid ?? "") { result in
                self.foodImageView.sd_setImage(with: result.recipeImageUrl, completed: nil)
                self.foodNameLabel.text = result.name
            }
        }
    }
    var transaction: AnyObject? {
        didSet {
            datePurchaseLbl.text = transaction?["purchaseDate"] as? String
            priceButton.setTitle(transaction?["price"] as? String, for: .normal)
        }
    }
    
    var foodImageView: UIImageView = {
        let fiv = UIImageView()
        fiv.image = #imageLiteral(resourceName: "shushi")
        fiv.contentMode = .scaleAspectFill
        fiv.clipsToBounds = true
        fiv.layer.borderWidth = 3
        fiv.layer.cornerRadius = 20
        fiv.translatesAutoresizingMaskIntoConstraints = false
        fiv.layer.borderColor = UIColor.white.cgColor
        return fiv
    }()
 
    lazy var foodNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sashimi Dinner"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.bold)
        
        return label
    }()
    lazy var datePurchaseLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "11.20.2020"
        lbl.textColor = .gray
        lbl.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.bold)
        
        return lbl
    }()
    let priceButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .orange
        button.layer.cornerRadius = 10
        button.setTitle("   $7   ", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 16)
        button.setTitleColor(.white, for: .normal)
        
        return button
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
        
        contentView.addSubview(foodImageView)
        foodImageView.snp.makeConstraints { make in
            make.width.height.equalTo(85)
            make.top.left.equalToSuperview().offset(15)
            //make.size.equalTo(contentView.frame.width-280)
            //make.left.equalToSuperview().offset(15)
        }
        contentView.addSubview(foodNameLabel)
        foodNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(foodImageView.snp.right).offset(20)
            
        }
        contentView.addSubview(datePurchaseLbl)
        datePurchaseLbl.snp.makeConstraints { make in
            //make.top.equalTo(foodNameLabel.snp.bottom).offset(20)
            make.left.equalTo(foodImageView.snp.right).offset(20)
            make.bottom.equalTo(foodImageView.snp.bottom)
        }
        contentView.addSubview(priceButton)
        priceButton.snp.makeConstraints { make in
            //make.top.equalTo(datePurchaseLbl.snp.bottom).offset(5)
            make.left.equalTo(contentView.snp.right).offset(-60)
            make.bottom.equalTo(foodImageView.snp.bottom)
        }
    }
}
