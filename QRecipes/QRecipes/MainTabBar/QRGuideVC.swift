//
//  QRGuideVC.swift
//  QRecipes
//
//  Created by Kyo on 10/14/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class QRGuideVC: UIViewController {
    //MARK:- Properties
    private let ratio = SplashVC.shared.ratio
    private let frame = UIView()
    private let titleLabel = UILabel()
    private let contentLabel = UILabel()
    private let qrButton = UIButton()
    private let location: String
    
    //MARK:- LifeCycles
    init(location: String) {
        self.location = location
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
    }
    
    //MARK:- Helpers
    private func configure() {
        view.backgroundColor = .clear
    }
    
    private func configureUI() {
        view.addSubview(frame)
        frame.backgroundColor = .white
        frame.layer.cornerRadius = 8
        frame.snp.makeConstraints { make in
            make.height.equalTo(view.frame.height / 2)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.center.equalToSuperview()
        }
        
        frame.addSubview(titleLabel)
        titleLabel.text = "How to purchase"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22 * ratio)
        titleLabel.textColor = .black
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(10)
            make.centerX.equalToSuperview()
        }
        
        frame.addSubview(contentLabel)
        contentLabel.text = "In order to puchase a reciep,\nyou need to go to\n\(location).\nAnd scan QR Code at the restaurant"
        contentLabel.font = UIFont.systemFont(ofSize: 15 * ratio)
        contentLabel.textColor = .darkGray
        contentLabel.textAlignment = .center
        contentLabel.numberOfLines = 0
        contentLabel.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(30)
            make.centerX.equalToSuperview()
        }
        
        frame.addSubview(qrButton)
        qrButton.setTitle("I'm at the restaurant!", for: .normal)
        qrButton.backgroundColor = .primeOrange
        qrButton.layer.cornerRadius = 10
        qrButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18 * ratio)
        qrButton.setTitleColor(.white, for: .normal)
        qrButton.addTarget(self, action: #selector(presentQRButton), for: .touchUpInside)
        qrButton.snp.makeConstraints { make in
            make.height.equalTo(60 * ratio)
            make.bottom.equalToSuperview().offset(-30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
    }

    //MARK:- Selectors
    @objc func presentQRButton() {
        dismiss(animated: true) {
            MainTabBar.shared.presentQRScanVC()
        }
    }

}
