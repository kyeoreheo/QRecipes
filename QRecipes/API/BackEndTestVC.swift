//
//  APITestVC.swift
//  QRecipes
//
//  Created by Kyo on 9/8/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import Firebase
import SnapKit
import UIKit

class BackEndTestVC: UIViewController {
    //MARK:- Properties
    private let sampleLable = UILabel()

    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
    }
    
    private func configure() {
        navigationController?.setNavigationBarHidden(true, animated: false)
        view.backgroundColor = .white
    }
    
    //MARK:- Helpers
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(sampleLable)
        sampleLable.text = "This is BackEndTestViewController"
        sampleLable.font = UIFont.systemFont(ofSize: 20)
        sampleLable.textColor = .black
        sampleLable.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(50)
        }
        
    }
    
    //MARK:- Selectors
    
}
