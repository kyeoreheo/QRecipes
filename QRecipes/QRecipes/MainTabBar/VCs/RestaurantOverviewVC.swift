//
//  RestaurantOverviewVC.swift
//  QRecipes
//
//  Created by Yiheng Cen Feng on 10/13/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class RestaurantOverviewVC: UIViewController {
    //MARK:- Properties
    var restaurants = [Restaurant]()
    
    var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    var imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.image = UIImage(named: "cupcakes")
        return img
    }()
    
    var infoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4
        return view
    }()
    
    var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .pumpkinRed
        button.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        return button
    }()
    
    var locationIcon: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .gray
        button.setImage(UIImage(systemName: "location"), for: .normal)
        return button
    }()
    
    var phoneIcon: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .gray
        button.setImage(UIImage(systemName: "phone"), for: .normal)
        return button
    }()
    
    var restaurantLabel: UILabel = {
        let label = UILabel()
        label.text = "Yummy Dessert Shop"
        label.textColor = .black
        label.font = UIFont(name:"Helvetica", size: 22)
        label.numberOfLines = 0
        return label
    }()

    var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "13 St Marks Pl, New York, NY 10003"
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.numberOfLines = 0
        return label
    }()
    
    var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "347-876-5746"
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 15)
        return label
    }()
    
    var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Top Picks"
        label.textColor = .charcoalBlack
        label.font = UIFont.boldSystemFont(ofSize: 18)
        return label
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4
        return view
    }()
    
    var tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.layer.cornerRadius = 8
        tv.register(RecipeCell.self, forCellReuseIdentifier: "cell")
        return tv
    } ()
    private let isInPurchaseFlow: Bool
    
    //MARK:- LifeCycles
    init(isInPurchaseFlow: Bool = false) {
        self.isInPurchaseFlow = isInPurchaseFlow
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
        fetchAllRestaurants()
    }
    
    //MARK:- Helpers
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureUI() {
        view.backgroundColor = .backgroundGray
        
        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.height.equalTo(view.frame.height*0.4)
            make.left.right.top.equalToSuperview()
        }
        
        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        view.addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.size.equalTo(150)
            if isInPurchaseFlow {
                make.top.equalTo(backButton.snp.bottom).offset(10)

            } else {
                make.top.equalTo(imageView.snp.bottom).offset(-75)
            }
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        infoView.addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(infoView).offset(10)
            make.right.equalTo(infoView).offset(-20)
        }
        
        infoView.addSubview(restaurantLabel)
        restaurantLabel.snp.makeConstraints { make in
            make.top.equalTo(infoView).offset(20)
            make.left.equalTo(infoView).offset(20)
            make.right.equalTo(favoriteButton.snp.left)
        }
        
        infoView.addSubview(locationIcon)
        locationIcon.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(restaurantLabel.snp.bottom).offset(15)
            make.left.equalTo(infoView).offset(20)
        }
        
        infoView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(restaurantLabel.snp.bottom).offset(15)
            make.left.equalTo(locationIcon.snp.right).offset(10)
            make.right.equalTo(infoView).offset(-20)
        }
        
        infoView.addSubview(phoneIcon)
        phoneIcon.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(locationLabel.snp.bottom)
            make.left.equalTo(infoView).offset(20)
        }
        
        infoView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.top.equalTo(locationLabel.snp.bottom)
            make.left.equalTo(phoneIcon.snp.right).offset(10)
            make.right.equalTo(infoView).offset(-20)
        }
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.size.equalTo(view.frame.height*0.4)
            make.top.equalTo(infoView.snp.bottom).offset(20)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-20)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(contentView).offset(10)
            make.left.equalTo(infoView).offset(10)
        }
        
        contentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(contentView.snp.bottom).offset(-10)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
    }
    
    func fetchAllRestaurants() {
        API.fetchAllRestaurants{ restaurants in
            self.restaurants = restaurants
        }
    }
    
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
}

extension RestaurantOverviewVC: UITableViewDataSource{
    // Deselect row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if !isInPurchaseFlow {
            guard let locationText = locationLabel.text
            else { return }
            let qrScanVC = QRGuideVC(location: locationText)
            qrScanVC.modalPresentationStyle = .popover
            present(qrScanVC, animated: true, completion: nil)
        } else {
            let purchaseVC = PurchaseVC(itemName: "pasta", payAmount: 12)
            navigationController?.pushViewController(purchaseVC, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipeCell

        cell.recipeLabel.text = "Pasta"
        
        if isInPurchaseFlow {
            cell.showPurchaseUI()
        }
        
        return cell
    }
}

extension RestaurantOverviewVC: UITableViewDelegate{
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
}
