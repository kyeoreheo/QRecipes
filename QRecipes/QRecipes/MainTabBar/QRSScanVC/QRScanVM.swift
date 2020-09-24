//
//  QRScanVM.swift
//  QRecipes
//
//  Created by Kyo on 9/23/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import AVFoundation

class QRScanVM {
    func frame(target: Any) -> UIView {
        let view = UIView()
        let titleLabel = UILabel()
        let handlerImage = UIImageView()
        let handler = UIButton()

        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.text = "QR Scan"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.left.equalToSuperview().offset(24)
        }
        
        view.addSubview(handlerImage)
        handlerImage.layer.cornerRadius = 3.0
        handlerImage.backgroundColor = .lightGray
        handlerImage.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(6)
            make.top.equalToSuperview().offset(6)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(handler)
        handler.snp.makeConstraints { make in
            make.width.equalTo(100)
            make.height.equalTo(30)
            make.top.equalToSuperview()
            make.centerX.equalToSuperview()
        }
        
        return view
    }
    
    func askCameraPermissionView(target: Any, action: Selector) -> UIView {
        let view = UIView()
        let noCameraHeaderLabel = UILabel()
        let noCameraPathLabel = UILabel()
        let cameraPermissionButton = UIButton()
        
        view.addSubview(noCameraHeaderLabel)
        noCameraHeaderLabel.text = "Allow camera permission"
        noCameraHeaderLabel.textColor = .black
        noCameraHeaderLabel.font = UIFont.boldSystemFont(ofSize: 24)
        noCameraHeaderLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(128)
        }

        view.addSubview(noCameraPathLabel)
        noCameraPathLabel.text = "To scan the QR-Code\nPlease allow camera permission"
        noCameraPathLabel.numberOfLines = 0
        noCameraPathLabel.textColor = .black
        noCameraPathLabel.font = UIFont.boldSystemFont(ofSize: 14)
        noCameraPathLabel.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(noCameraHeaderLabel.snp.bottom).offset(8)
        }
        
        view.addSubview(cameraPermissionButton)
        cameraPermissionButton.backgroundColor = .gray
        cameraPermissionButton.setTitle("Go to setting", for: .normal)
        cameraPermissionButton.setTitleColor(.white, for: .normal)
        cameraPermissionButton.addTarget(target, action: action, for: .touchUpInside)
        cameraPermissionButton.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(noCameraPathLabel.snp.bottom).offset(16)
            make.left.equalToSuperview().offset(24)
            make.right.equalToSuperview().offset(-24)
            make.height.equalTo(40)
        }
              
        return view
    }
}
