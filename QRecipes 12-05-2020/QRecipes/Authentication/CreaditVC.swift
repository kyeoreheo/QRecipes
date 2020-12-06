//
//  CreaditVC.swift
//  QRecipes
//
//  Created by Kyo on 9/14/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class CreditVC: UIViewController, UIGestureRecognizerDelegate {
    //MARK:- Properties
    private let viewModel = AuthenticationVM()
    private lazy var yiheng = viewModel.personInfoView(name: "Yiheng Cen Feng", position: "(Front End)", email: "abc@gmail.com")
    private lazy var dan = viewModel.personInfoView(name: "Dan Zhao", position: "(Front End)", email: "zhaodan618@gmail.com")
    private lazy var kyo = viewModel.personInfoView(name: "Kyeore Heo", position: "(Full Stack)", email: "91kyoheo@gmail.com")
    private lazy var mingu = viewModel.personInfoView(name: "Mingu Choi", position: "(Back End)", email: "mingu0629@gmail.com")
    
    private lazy var navBar = CustomView().navigationBar(target: self, action: #selector(dismissView))

    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
    }
    
    //MARK:- Helpers
    private func configure() {
        view.backgroundColor = .white
    }
    
    private func configureUI() {
        view.addSubview(navBar)
        navBar.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
        
        view.addSubview(yiheng)
        yiheng.backgroundColor = .lightlightGray
        yiheng.layer.cornerRadius = 10
        yiheng.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(100)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(110)
        }
        
        view.addSubview(dan)
        dan.backgroundColor = .lightlightGray
        dan.layer.cornerRadius = 10
        dan.snp.makeConstraints { make in
            make.top.equalTo(yiheng.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(100)
        }
        
        view.addSubview(kyo)
        kyo.backgroundColor = .lightlightGray
        kyo.layer.cornerRadius = 10
        kyo.snp.makeConstraints { make in
            make.top.equalTo(dan.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.height.equalTo(100)
        }
        
        view.addSubview(mingu)
        mingu.backgroundColor = .lightlightGray
        mingu.layer.cornerRadius = 10
        mingu.snp.makeConstraints { make in
            make.top.equalTo(kyo.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-35)
            make.height.equalTo(100)
        }

    }
    
    //MARK:- Selectors
    @objc func dismissView() {
        dismiss(animated: true, completion: nil)
    }
    
}
