//
//  OwnerHomeVC.swift
//  QRecipes
//
//  Created by Mingu Choi on 2020/12/05.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class OwnerHomeVC: UIViewController {
    
    //MARK:- Properties
    let label: UILabel = {
        let label = UILabel()
        label.text = "Owner successfully logged in"
        label.font = UIFont.boldSystemFont(ofSize: 22)
        label.textColor = .black
        
        return label
    }()
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }

    //MARK:- Helpers
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(label)
        label.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.centerY.equalToSuperview()
        }
    }
}
