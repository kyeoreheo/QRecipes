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
    
    var transactions = [String:AnyObject]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    let titleLabel: UILabel = {
       let label = UILabel()
       label.text = "Receipt"
       label.textColor = .black
       label.font = UIFont.boldSystemFont(ofSize: 28)
       return label
    }()
    var receiptView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4
        view.backgroundColor = .white
        return view
    }()
    lazy var tableView: UITableView = {
        let tv = UITableView()
        
        tv.register(TransactionCell.self, forCellReuseIdentifier: "cell")
        return tv
    } ()
    /*var foodImageView: UIImageView = {
        let fiv = UIImageView()
        fiv.image = #imageLiteral(resourceName: "shushi")
        fiv.contentMode = .scaleAspectFill
        fiv.clipsToBounds = true
        fiv.layer.borderWidth = 3
        fiv.layer.cornerRadius = 8
        fiv.translatesAutoresizingMaskIntoConstraints = false
        fiv.layer.borderColor = UIColor.white.cgColor
        return fiv
    }()
 
    lazy var foodNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Sashimi Dinner"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16 * ratio, weight: UIFont.Weight.bold)
        
        return label
    }()
    lazy var datePurchaseLbl : UILabel = {
        let lbl = UILabel()
        lbl.text = "11.20.2020"
        lbl.textColor = .gray
        lbl.font = UIFont.systemFont(ofSize: 16 * ratio, weight: UIFont.Weight.bold)
        
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
    }()*/
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        fetchTransaction()
        super.viewDidAppear(animated)
    }
    
    //MARK:- Helpers
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureUI() {
        view.backgroundColor = .white

        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(12)
            make.left.equalTo(backButton.snp.right).offset(12)
        }
        view.addSubview(receiptView)
        receiptView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(110)
            make.left.right.bottom.equalToSuperview()
            make.bottom.equalToSuperview().offset(-100)
        }
        receiptView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(15)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalTo(receiptView.snp.bottom).offset(-10)
        }
        /*tableView.addSubview(foodImageView)
        foodImageView.snp.makeConstraints { make in
            make.width.height.equalTo(90 * ratio)
            make.top.left.equalToSuperview().offset(15)
            make.size.equalTo(view.frame.width-280)
            //make.left.equalToSuperview().offset(15)
        }
        tableView.addSubview(foodNameLabel)
        foodNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(15)
            make.left.equalTo(foodImageView.snp.right).offset(20)
            
        }
        tableView.addSubview(datePurchaseLbl)
        datePurchaseLbl.snp.makeConstraints { make in
            make.top.equalTo(foodNameLabel.snp.bottom).offset(20)
            make.left.equalTo(foodImageView.snp.right).offset(20)
            
        }
        tableView.addSubview(priceButton)
        priceButton.snp.makeConstraints { make in
            make.top.equalTo(datePurchaseLbl.snp.bottom).offset(5)
            make.left.equalTo(receiptView.snp.right).offset(-80)
            
        }*/
        
    }
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    func fetchTransaction() {
        API.fetchReceipt { transactions in
            self.transactions = transactions
        }
    }
}

extension ReceiptViewVC: UITableViewDataSource, UITableViewDelegate{
    // Deselect row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("DEBUG:- # of transactions \(transactions.count)")
        return transactions.count  //Choose your custom row number
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0;//Choose your custom row height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! TransactionCell
        var itr = 0
        for transaction in transactions {
            if indexPath.row == itr {
                cell.recipeUid = transaction.key
                cell.transaction = transaction.value
                print("DEBUG:- at \(itr)th element, uid: \(transaction.key), value: \(transaction.value)")
            }
            itr += 1
        }
        return cell
    }
}

