//
//  UploadVC.swift
//  QRecipes
//
//  Created by Yiheng Cen Feng on 12/6/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class UploadVC: UIViewController, UIGestureRecognizerDelegate, UITextViewDelegate {
    //MARK:- Properties
    private let ratio = SplashVC.shared.ratio
   
    private let cancelButton = UIButton()
    private let titleLabel = UILabel()
    
    private let keywordsLabel = UILabel()
    private let recipeNameTextField = UITextField()
    private let keywordsTextView = UITextView()
    
    private let nextButton = UIButton()

    private let imagePicker = UIImagePickerController()
    private var recipeImage = UIImage()
    private let addPhotoButton = UIButton()

    private var recipeName = ""
    private var keywords = ""
    private var keywordsArr = [String]()
    
    private var allFilled = false
    
    //MARK:- LifeCycles
    override func viewDidLoad() {
    super.viewDidLoad()
        configure()
        configureUI()
    }
    
    //MARK:- Helpers
    private func configure() {
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
    }

    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(cancelButton)
        cancelButton.backgroundColor = .clear
        cancelButton.setTitle("Cancel", for: .normal)
        cancelButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        cancelButton.setTitleColor(.darkGray, for: .normal)
        cancelButton.contentHorizontalAlignment = .left
        cancelButton.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        cancelButton.snp.makeConstraints { make in
            make.height.equalTo(40)
            make.width.equalTo(100)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(20)
        }

        view.addSubview(titleLabel)
        titleLabel.text = "Upload Recipe"
        titleLabel.textColor = .black
        titleLabel.font = UIFont.boldSystemFont(ofSize: 30 * ratio)
        titleLabel.snp.makeConstraints { make in
            make.top.equalTo(cancelButton.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(30)
        }

        view.addSubview(addPhotoButton)
        addPhotoButton.layer.masksToBounds = true
        addPhotoButton.layer.borderWidth = 2
        addPhotoButton.layer.borderColor = UIColor.gray.cgColor
        addPhotoButton.setTitle("Add Photo", for: .normal)
        addPhotoButton.setTitleColor(.black, for: .normal)
        addPhotoButton.addTarget(self, action: #selector(addPhoto), for: .touchUpInside)
        addPhotoButton.snp.makeConstraints { make in
            make.width.equalTo((view.frame.width-120) * ratio)
            make.height.equalTo((view.frame.width-160) * ratio)
            make.top.equalTo(titleLabel.snp.bottom).offset(15)
            make.centerX.equalToSuperview()
        }

        view.addSubview(recipeNameTextField)
        recipeNameTextField.attributedPlaceholder = NSAttributedString(string: " Recipe name", attributes: [NSAttributedString.Key.foregroundColor : UIColor.lightlightGray, NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 18)])
        recipeNameTextField.textColor = .black
        recipeNameTextField.backgroundColor = .white
        recipeNameTextField.layer.borderWidth = 1
        recipeNameTextField.layer.cornerRadius = 6
        recipeNameTextField.layer.borderColor = UIColor.lightlightGray.cgColor
        recipeNameTextField.keyboardType = .default
        recipeNameTextField.addTarget(self, action: #selector(recipeNameTextFieldDidChange), for: .editingChanged)
        recipeNameTextField.autocorrectionType = .no
        recipeNameTextField.delegate = target as? UITextFieldDelegate
        recipeNameTextField.snp.makeConstraints { make in
            make.height.equalTo(36 * ratio)
            make.top.equalTo(addPhotoButton.snp.bottom).offset(20)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }

        view.addSubview(keywordsLabel)
        keywordsLabel.text = "keywords:"
        keywordsLabel.textColor = .black
        keywordsLabel.font = UIFont.boldSystemFont(ofSize: 18 * ratio)
        keywordsLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeNameTextField.snp.bottom).offset(15)
            make.left.equalToSuperview().offset(30)
        }
        
        view.addSubview(keywordsTextView)
        keywordsTextView.text = "Enter search keywords here [separated by commma] ..."
        keywordsTextView.textColor = .lightGray
        keywordsTextView.font = UIFont.systemFont(ofSize: 18)
        keywordsTextView.backgroundColor = .white
        keywordsTextView.layer.borderColor = UIColor.lightlightGray.cgColor
        keywordsTextView.layer.borderWidth = 1
        keywordsTextView.layer.cornerRadius = 6
        keywordsTextView.keyboardType = .default
        keywordsTextView.delegate = self
        keywordsTextView.autocorrectionType = .no
        keywordsTextView.isScrollEnabled = false
        keywordsTextView.snp.makeConstraints { make in
            make.height.equalTo(80 * ratio)
            make.top.equalTo(keywordsLabel.snp.bottom).offset(5)
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
        }

        view.addSubview(nextButton)
            nextButton.backgroundColor = .lightGray
            nextButton.layer.cornerRadius = 10
            nextButton.setTitle("Next", for: .normal)
            nextButton.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18 * ratio)
            nextButton.setTitleColor(.white, for: .normal)
            nextButton.addTarget(self, action: #selector(pushUploadContVC), for: .touchUpInside)
            nextButton.snp.makeConstraints { make in
            make.height.equalTo(45 * ratio)
            make.top.equalTo(keywordsTextView.snp.bottom).offset(30)
            make.left.equalTo(view.snp.centerX).offset(15)
            make.right.equalToSuperview().offset(-30)
        }
    }
    
    func checkValidity() {
        if recipeImage.size.width != 0 && recipeName != "" && keywords != ""{
            nextButton.backgroundColor = .primeOrange
            allFilled = true
        } else {
            allFilled = false
            nextButton.backgroundColor = .lightGray
        }
    }
    
    func splitString(string: String) {
        keywordsArr = keywords.components(separatedBy: ",")
    }

    //MARK:- Selectors
    @objc func recipeNameTextFieldDidChange(_ textField: UITextField) {
        guard let recipeName = textField.text else { return }
        self.recipeName = recipeName
        checkValidity()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        guard let keywords = textView.text else { return }
        self.keywords = keywords
        checkValidity()
    }
        
    func textViewDidBeginEditing(_ textView: UITextView) {
        textView.text = nil
        textView.textColor = UIColor.black
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.isEmpty {
            textView.text = "Enter search keywords here [separated by commma] ..."
            textView.textColor = .lightGray
        }
    }

    @objc func addPhoto() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    @objc func pushUploadContVC() {
        if allFilled {
            splitString(string: keywords)

            let vc = UploadContVC()
            vc.recipeImage = recipeImage
            vc.recipeName = recipeName
            vc.keywordsArr = keywordsArr
            navigationController?.pushViewController(vc, animated: true)
        } else {
            let alert = UIAlertController(title: "Need to fill out all sections before proceeding", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
            self.present(alert, animated: true)
        }
    }
    
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
}

extension UploadVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let recipeImage = info [.editedImage] as? UIImage else { return }
        self.recipeImage = recipeImage

        addPhotoButton.imageView?.contentMode = .scaleAspectFill
        addPhotoButton.imageView?.clipsToBounds = true
        addPhotoButton.layer.borderColor = UIColor.white.cgColor
        addPhotoButton.layer.borderWidth = 3

        self.addPhotoButton.setImage(recipeImage.withRenderingMode(.alwaysOriginal), for: .normal)

        checkValidity()
        dismiss(animated: true, completion: nil)
    }
}
