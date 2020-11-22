//
//  ReceiptViewVC.swift
//  QRecipes
//
//  Created by Dannyyyyyyy Zhao on 11/17/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class ReceiptViewVC: UIViewController {

    private let ratio = SplashVC.shared.ratio
    
//    lazy var backView: UIView = {
//        let view = UIView()
//        return view
//    }()
    lazy var titleLabel: UILabel = {
       let label = UILabel()
       label.text = "Receipt:"
       label.textColor = .black
       label.font = UIFont.boldSystemFont(ofSize: 28)
       return label
    }()
    let tableView: UITableView = {
        let tv = UITableView()
        tv.backgroundColor = .white
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    } ()
    
    lazy var foodImage: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.layer.cornerRadius = 8
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    lazy var nameLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.textColor = .black
        return lbl
    }()
    lazy var datePurchaseLbl : UILabel = {
        let lbl = UILabel()
        lbl.font = UIFont.boldSystemFont(ofSize: 15)
        lbl.textColor = .black
        return lbl
    }()
    let priceButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.cornerRadius = 20
        button.setTitle("$7", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 12)
        button.setTitleColor(.primeOrange, for: .normal)
        return button
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
    }
    //MARK:- Helpers
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureUI() {
        view.backgroundColor = .backgroundGray
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view).offset(12)
        }
    //    view.addSubview(backView)
    //    backView.snp.makeConstraints { make in
    //        make.top.left.right.bottom.equalToSuperview()
    //    }
        view.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.right.bottom.equalToSuperview()
        }
        tableView.addSubview(foodImage)
        foodImage.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.width.equalTo(40)
        }
        tableView.addSubview(nameLbl)
        nameLbl.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.left.equalTo(foodImage.snp.right).offset(20)
        }
        tableView.addSubview(datePurchaseLbl)
        datePurchaseLbl.snp.makeConstraints { make in
            make.top.equalTo(nameLbl.snp.bottom).offset(30)
            make.left.equalTo(foodImage.snp.right).offset(20)
        }
        tableView.addSubview(priceButton)
        priceButton.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-30)
            make.top.equalTo(datePurchaseLbl.snp.bottom).offset(20)
        }
        
    }
    
}
extension ReceiptViewVC: UITableViewDataSource, UITableViewDelegate{
    // Deselect row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10 //Choose your custom row number
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0;//Choose your custom row height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)

        return cell
    }
}

