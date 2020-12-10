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
    
    var transactions = [Dictionary<String, AnyObject>.Element]() {
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
        tv.backgroundColor = .white
        tv.register(TransactionCell.self, forCellReuseIdentifier: "cell")
        return tv
    } ()
    
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
            }
            itr += 1
        }
        return cell
    }
}

