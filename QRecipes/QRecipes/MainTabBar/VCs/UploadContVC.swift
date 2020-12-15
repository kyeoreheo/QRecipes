//
//  UploadContVC.swift
//  QRecipes
//
//  Created by Yiheng Cen Feng on 12/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class UploadContVC: UIViewController, UITextViewDelegate {
    //MARK:- Properties
    private let ratio = SplashVC.shared.ratio
    
    private let backButton = UIButton()
    
    private let ingredientsLabel = UILabel()
    private let instructionLabel = UILabel()
    private let ingredientsTextView = UITextView()
    private let instructionTextView = UITextView()
    
    private let uploadButton = UIButton()

    private var ingredients = ""
    private var instructions = ""
    private var ingredientsArr = [String]()
    
    var recipeImage = UIImage()
    var recipeName = ""
    var keywordsArr = [String]()
    
    private var allFilled = false

    //MARK:- LifeCycles
    override func viewDidLoad() {
    super.viewDidLoad()
        configureUI()
    }
    
    //MARK:- Helpers
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(backButton)
        backButton.backgroundColor = .clear
        backButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        backButton.setImage(UIImage(named: "arrow-left"), for: .normal)
        backButton.contentMode = .scaleAspectFit
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(20)
        }
        
        view.addSubview(ingredientsLabel)
        ingredientsLabel.text = "Ingredients:"
        ingredientsLabel.textColor = .black
        ingredientsLabel.font = UIFont.boldSystemFont(ofSize: 18 * ratio)
        ingredientsLabel.snp.makeConstraints { make in
            make.top.equalTo(backButton.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(30)
        }
        
        view.addSubview(ingredientsTextView)
        ingredientsTextView.text = "Enter ingredietns here [separated by commma] ..."
        ingredientsTextView.textColor = .lightGray
        ingredientsTextView.font = UIFont.systemFont(ofSize: 18)
        ingredientsTextView.backgroundColor = .white
        ingredientsTextView.layer.borderColor = UIColor.lightlightGray.cgColor
        ingredientsTextView.layer.borderWidth = 1
        ingredientsTextView.layer.cornerRadius = 6
        ingredientsTextView.keyboardType = .default
        ingredientsTextView.delegate = self
        ingredientsTextView.autocorrectionType = .no
        ingredientsTextView.isScrollEnabled = false
        ingredientsTextView.snp.makeConstraints { make in
            make.height.equalTo(160 * ratio)
            make.top.equalTo(ingredientsLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }
        
        view.addSubview(instructionLabel)
        instructionLabel.text = "Instructions:"
        instructionLabel.textColor = .black
        instructionLabel.font = UIFont.boldSystemFont(ofSize: 18 * ratio)
        instructionLabel.snp.makeConstraints { make in
            make.top.equalTo(ingredientsTextView.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(30)
        }
        
        view.addSubview(instructionTextView)
        instructionTextView.text = "Enter instruction here ..."
        instructionTextView.textColor = .lightGray
        instructionTextView.font = UIFont.systemFont(ofSize: 18)
        instructionTextView.backgroundColor = .white
        instructionTextView.layer.borderColor = UIColor.lightlightGray.cgColor
        instructionTextView.layer.borderWidth = 1
        instructionTextView.layer.cornerRadius = 6
        instructionTextView.keyboardType = .default
        instructionTextView.delegate = self
        instructionTextView.autocorrectionType = .no
        instructionTextView.isScrollEnabled = false
        instructionTextView.snp.makeConstraints { make in
            make.height.equalTo(200 * ratio)
            make.top.equalTo(instructionLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }

        view.addSubview(uploadButton)
            uploadButton.backgroundColor = .lightGray
            uploadButton.layer.cornerRadius = 10
            uploadButton.setTitle("Upload Recipe", for: .normal)
            uploadButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18 * ratio)
            uploadButton.setTitleColor(.white, for: .normal)
            uploadButton.addTarget(self, action: #selector(uploadRecipe), for: .touchUpInside)
            uploadButton.snp.makeConstraints { make in
            make.height.equalTo(50 * ratio)
            make.top.equalTo(instructionTextView.snp.bottom).offset(30)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
        }
    }

    func checkValidity() {
        if ingredients != "" && instructions != "" {
            allFilled = true
            uploadButton.backgroundColor = .primeOrange
        } else {
            allFilled = false
            uploadButton.backgroundColor = .lightGray
        }
    }
    
    func splitString(string: String) {
        ingredientsArr = ingredients.components(separatedBy: ",")
    }

    //MARK:- Selectors
    func textViewDidChange(_ textView: UITextView) {
        guard let text = textView.text else { return }
        
        if textView == ingredientsTextView {
            self.ingredients = text
        } else {
            self.instructions = text
        }
        
        checkValidity()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
        textView.textColor = .black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            if textView == ingredientsTextView {
                textView.text = "Enter ingredietns here [separated by commma] ..."
            } else {
                textView.text = "Enter instruction here ..."
            }
            textView.textColor = .lightGray
        }
    }
    
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func uploadRecipe() {
        if allFilled {
            splitString(string: ingredients)
            
            let vc = FinishedUploadVC()
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "Need to fill out all sections before uploading", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
}
