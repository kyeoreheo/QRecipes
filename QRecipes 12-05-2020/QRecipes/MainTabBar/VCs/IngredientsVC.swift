//
//  IngredientsVC.swift
//  QRecipes
//
//  Created by Yiheng Cen Feng on 10/19/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class IngredientsVC: UIViewController {
    //MARK:- Properties
    var ingredients : [String]? {
        didSet{
            tableView.reloadData()
        }
    }
    
    var listView: UIView = {
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
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tv
    } ()
    
    //MARK:- LifeCycles
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
        view.backgroundColor = .white
        
        view.addSubview(listView)
        listView.snp.makeConstraints { make in
            make.size.equalTo(view.frame.height-40)
            make.top.left.equalToSuperview().offset(20)
            make.bottom.right.equalToSuperview().offset(-20)
        }
        
        listView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(10)
            make.bottom.right.equalToSuperview().offset(-10)
        }
    }
}

extension IngredientsVC: UITableViewDataSource, UITableViewDelegate{
    // Deselect row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return ingredients?.count ?? 10
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.backgroundColor = .white
        cell.textLabel?.textColor = .gray
        cell.textLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        cell.textLabel?.text = ingredients?[indexPath.row]
        return cell
    }
}
