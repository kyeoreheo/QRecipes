//
//  PurchaseVC.swift
//  QRecipes
//
//  Created by Kyo on 10/14/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit

class PurchaseVC: UIViewController {
    //MARK:- Properties
    private let ratio = SplashVC.shared.ratio
    private let backButton = UIButton()
    
    private let titleLabel = UILabel()
    private let selectedPayMethodImageView = UIImageView()
    private let divider = UIView()
    private let placeHolderLabel = UILabel()
    private let applePayButton = UIButton()
    private let googlePayButton = UIButton()
    private let paypalButton = UIButton()
    private let venmoButton = UIButton()
    private let contentLabel = UILabel()
    private let payButton = UIButton()
    
    private let itemName: String
    private var payAmount: String
    private let uid: String
    private let isInPurchaseFlow: Bool
    
    //MARK:- LifeCycles
    init(itemName: String, payAmount: String, uid: String, isInPurchaseFlow: Bool = false) {
        self.itemName = itemName
        self.payAmount = payAmount
        self.uid = uid
        self.isInPurchaseFlow = isInPurchaseFlow
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
        updatePayAmount()
    }
    
    //MARK:- Helpers
    private func configure() {
        view.backgroundColor = .white
    }
    
    private func configureUI() {
        view.addSubview(backButton)
        backButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        backButton.setImage(UIImage(named: "arrow-left"), for: .normal)
        backButton.contentMode = .scaleAspectFit
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        
        view.addSubview(titleLabel)
        /*let number = payAmount.replacingOccurrences(of: "$", with: "")
        if isInPurchaseFlow {
            titleLabel.text = "\(itemName) \(payAmount) -> \(Int(Int(number)! / 2))"
        } else {
            titleLabel.text = "\(itemName) \(payAmount)"
        }*/
        titleLabel.text = "\(itemName) \(payAmount)"
        titleLabel.font = UIFont.boldSystemFont(ofSize: 22 * ratio)
        titleLabel.textColor = .darkGray
        titleLabel.snp.makeConstraints { make in
            make.centerY.equalTo(backButton.snp.centerY)
            make.centerX.equalToSuperview()
        }
        
        view.addSubview(selectedPayMethodImageView)
        selectedPayMethodImageView.contentMode = .scaleAspectFit
        selectedPayMethodImageView.backgroundColor = .lightGray
        selectedPayMethodImageView.layer.cornerRadius = 8
        selectedPayMethodImageView.snp.makeConstraints { make in
            make.height.equalTo(200 * ratio)
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        view.addSubview(divider)
        divider.backgroundColor = .lightGray
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
            make.top.equalTo(selectedPayMethodImageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        selectedPayMethodImageView.addSubview(placeHolderLabel)
        placeHolderLabel.text = "Select your pay method"
        placeHolderLabel.font = UIFont.boldSystemFont(ofSize: 20 * ratio)
        placeHolderLabel.textColor = .white
        placeHolderLabel.snp.makeConstraints { make in
            make.center.equalToSuperview()
        }
        
        view.addSubview(applePayButton)
        applePayButton.setImage(UIImage(named: "applePay"), for: .normal)
        applePayButton.imageView?.contentMode = .scaleAspectFit
        applePayButton.addTarget(self, action: #selector(selectedPayMethod), for: .touchUpInside)
        applePayButton.snp.makeConstraints { make in
            let size = view.frame.width / 2 - 45
            make.width.height.equalTo(size)
            make.top.equalTo(selectedPayMethodImageView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalTo(selectedPayMethodImageView.snp.centerX).offset(-15)
        }
        
        view.addSubview(googlePayButton)
        googlePayButton.setImage(UIImage(named: "googlePay"), for: .normal)
        googlePayButton.imageView?.contentMode = .scaleAspectFit
        googlePayButton.addTarget(self, action: #selector(selectedPayMethod), for: .touchUpInside)
        googlePayButton.snp.makeConstraints { make in
            let size = view.frame.width / 2 - 45
            make.width.height.equalTo(size)
            make.top.equalTo(selectedPayMethodImageView.snp.bottom).offset(30)
            make.left.equalTo(selectedPayMethodImageView.snp.centerX).offset(15)
            make.right.equalToSuperview().offset(-30)
        }
        
        view.addSubview(venmoButton)
        venmoButton.setImage(UIImage(named: "Venmo"), for: .normal)
        venmoButton.imageView?.contentMode = .scaleAspectFit
        venmoButton.addTarget(self, action: #selector(selectedPayMethod), for: .touchUpInside)
        venmoButton.snp.makeConstraints { make in
            let size = view.frame.width / 2 - 45
            make.width.height.equalTo(size)
            make.top.equalTo(applePayButton.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(30)
            make.right.equalTo(selectedPayMethodImageView.snp.centerX).offset(-15)
        }
        
        view.addSubview(paypalButton)
        paypalButton.setImage(UIImage(named: "paypal"), for: .normal)
        paypalButton.imageView?.contentMode = .scaleAspectFit
        paypalButton.addTarget(self, action: #selector(selectedPayMethod), for: .touchUpInside)
        paypalButton.snp.makeConstraints { make in
            let size = view.frame.width / 2 - 45
            make.width.height.equalTo(size)
            make.top.equalTo(applePayButton.snp.bottom).offset(30)
            make.left.equalTo(selectedPayMethodImageView.snp.centerX).offset(15)
            make.right.equalToSuperview().offset(-30)
        }
        
        view.addSubview(payButton)
        payButton.setTitle("Select a Purchase method", for: .normal)
        payButton.isUserInteractionEnabled = false
        payButton.backgroundColor = .lightGray
        payButton.layer.cornerRadius = 10
        payButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18 * ratio)
        payButton.setTitleColor(.white, for: .normal)
        payButton.addTarget(self, action: #selector(purchase), for: .touchUpInside)
        payButton.snp.makeConstraints { make in
            make.height.equalTo(60 * ratio)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-30)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
    }
    
    func animatePayMethod(_ image: UIImage) {
        selectedPayMethodImageView.image = image
        selectedPayMethodImageView.backgroundColor = .clear
        payButton.backgroundColor = .primeOrange
        payButton.setTitle("Purchase", for: .normal)
        placeHolderLabel.isHidden = true
        payButton.isUserInteractionEnabled = true
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: { [weak self] in
            guard let strongSelf = self else { return }
            strongSelf.selectedPayMethodImageView.transform = CGAffineTransform(scaleX: 1.1, y: 1.1)
        }) { _ in
            UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.3, initialSpringVelocity: 0.5, options: .curveEaseIn, animations: { [weak self] in
                guard let strongSelf = self else { return }
                strongSelf.selectedPayMethodImageView.transform = CGAffineTransform(scaleX: 0.9, y: 0.9)
            })
        }
    }

    //MARK:- Selectors
    func updatePayAmount() -> Void {
        let number = payAmount.replacingOccurrences(of: "$", with: "")
        if isInPurchaseFlow {
            payAmount = "\(Int(Int(number)! / 2))"
        }
    }
    @objc func purchase() {
        //navigationController?.pushViewController(FinishedPurchaseVC(itemName
                                                   // : itemName), animated: true)
        API.purhcaseRecipe(recipeUid: uid, price: payAmount) { [weak self] (error, ref) in
            guard let strongSelf = self else { return }
            if error != nil {
                print("Error: failed to purchase")
            } else {
                strongSelf.navigationController?.pushViewController(FinishedPurchaseVC(itemName: strongSelf.itemName),animated: true)
            }
        }
    }

    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func selectedPayMethod(sender: UIButton) {
        guard let image = sender.imageView?.image
        else { return }
        animatePayMethod(image)
    }
    
}
