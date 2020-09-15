//
//  PlaceHolderVC.swift
//  QRecipes
//
//  Created by Kyo on 9/14/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class PlaceHolderVC: UIViewController, UIGestureRecognizerDelegate {
    //MARK:- Properties
    private let sampleLable = UILabel()

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
        view.addSubview(sampleLable)
        sampleLable.text = "This is a QR cameraTab"
        sampleLable.textColor = .black
        sampleLable.font = UIFont.systemFont(ofSize: 20)
        sampleLable.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
    }
    
    //MARK:- Selectors
    
}
