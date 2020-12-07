//
//  RecipeInfoViewVC.swift
//  QRecipes
//
//  Created by Dan Zhao on 10/19/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class RecipeInfoViewVC: UIViewController {
    
    //MARK:- Properties
    var recipe: Recipe? {
        didSet {
            recipeImageView.sd_setImage(with: recipe?.recipeImageUrl, completed: nil)
            restaurantLabel.text = recipe?.restaurant
            titleLabel.text = recipe?.name
            cookTimeLabel.text = "Cook Time: " + recipe!.cookTime
            cookDifficultyLabel.text = "Difficulty: " + recipe!.level
        }
    }
    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.backgroundColor = .black
        view.layer.cornerRadius = 8
        view.contentSize.width = view.frame.width;
        return view
    }()
    
    var favIsOn = false
    private let ratio = SplashVC.shared.ratio
    
    var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    var restarantImageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.image = UIImage(named: "pasta-restaurant")
        return img
    }()
    
    var infoView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4
        return view
    }()
    var commentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4
        return view
    }()
    var favoriteButton: UIButton = {
        let button = UIButton(type: .custom)
        button.backgroundColor = .backgroundGray
        button.alpha = 0.9
        button.layer.cornerRadius = 20
        button.tintColor = .primeOrange
        button.setImage(UIImage(systemName: "heart"), for: .normal)
        button.addTarget(self, action: #selector(buttonPressed), for: .touchUpInside)
        return button
    }()
    
    var purchaseButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .primeOrange
        button.layer.cornerRadius = 10
        button.setTitle("Purchase", for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 18)
        button.setTitleColor(.white, for: .normal)
        button.addTarget(self, action: #selector(pressPurchaseButton), for: .touchUpInside)
        return button
    }()
    
    var locationIcon: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .gray
        button.setImage(UIImage(systemName: "location"), for: .normal)
        return button
    }()
    
    var phoneIcon: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .gray
        button.setImage(UIImage(systemName: "phone"), for: .normal)
        return button
    }()
    
    lazy var restaurantLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont(name:"Helvetica", size: 18 * ratio)
        return label
    }()

    lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.text = "13 St Marks Pl, New York, NY 10003"
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14 * ratio)
        label.numberOfLines = 0
        return label
    }()
    
    lazy var phoneLabel: UILabel = {
        let label = UILabel()
        label.text = "347-876-5746"
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14 * ratio)
        return label
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Recipe's Detail"
        label.textColor = .charcoalBlack
        label.font = UIFont.boldSystemFont(ofSize: 16 * ratio)
        return label
    }()
    
    lazy var cookTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "Cook Time: 30 mins"
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14 * ratio)
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    lazy var cookDifficultyLabel: UILabel = {
        let label = UILabel()
        label.text = "Difficulty: Easy"
        label.textAlignment = .center
        label.textColor = .darkGray
        label.font = UIFont.boldSystemFont(ofSize: 14 * ratio)
        return label
    }()
    var contentView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 8
        view.backgroundColor = .white
        view.layer.shadowColor = UIColor.lightGray.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = .zero
        view.layer.shadowRadius = 4
        return view
    }()
    
    var recipeImageView: UIImageView = {
        let rimg = UIImageView()
        rimg.contentMode = .scaleAspectFill
        rimg.clipsToBounds = true
        rimg.layer.cornerRadius = 8
        rimg.backgroundColor = .white
        rimg.layer.shadowColor = UIColor.lightGray.cgColor
        rimg.layer.shadowOpacity = 0.5
        rimg.layer.shadowOffset = .zero
        rimg.layer.shadowRadius = 4
        rimg.isUserInteractionEnabled = true
        return rimg
    }()
    lazy var commentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Comments "
        label.textColor = .primeOrange
        label.font = UIFont(name:"Helvetica", size: 18 * ratio)
        return label
    }()
    
    var commentTextField: UITextField = {
        let commentTextField = UITextField()
        commentTextField.placeholder = "Add a comment here...."
        //commentTextField.borderStyle = UITextField.BorderStyle.roundedRect
        commentTextField.keyboardType = UIKeyboardType.default
        commentTextField.returnKeyType = UIReturnKeyType.done
        commentTextField.textColor = .black
        
        return commentTextField
    }()
    var submitButton: UIButton = {
        let submitButton = UIButton(type: .custom)
        submitButton.tintColor = .gray
        submitButton.backgroundColor = .white
        submitButton.setTitle("submit", for: .normal)
        submitButton.setTitleColor(.primeOrange, for: .normal)
        submitButton.contentMode = .scaleAspectFit
        return submitButton
    }()
    
    lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.register(CommentCell.self, forCellReuseIdentifier: "cell")
        return tv
    } ()
    /*
    var profileImageView: UIImageView = {
        let iv = UIImageView()
        iv.image = #imageLiteral(resourceName: "profile")
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.layer.borderWidth = 3
        iv.layer.cornerRadius = 25
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.borderColor = UIColor.white.cgColor
        return iv
    }()
    lazy var userNameLabel: UILabel = {
        let label = UILabel()
        label.text = "Danny"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 13 * ratio, weight: UIFont.Weight.bold)
        
        return label
    }()
    lazy var commentLabel: UILabel = {
        let label = UILabel()
        label.text = "Love it, it is easy to follow.Thank you. :)"
        label.textColor = .black
        label.font = UIFont(name:"Helvetica", size: 14 * ratio)
        label.textAlignment = .left
        label.numberOfLines = 0
        label.sizeToFit()
        
        return label
    }()
    lazy var thumbsUpButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .primeOrange
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "hand.thumbsup"), for: .normal)
        
        return button
    }()
    lazy var thumbsDownButton: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .primeOrange
        button.backgroundColor = .white
        button.setImage(UIImage(systemName: "hand.thumbsdown"), for: .normal)
        
        return button
    }()
 */
    
    private let isInPurchaseFlow: Bool
    
    //MARK:- LifeCycles
    init(isInPurchaseFlow: Bool = false) {
        self.isInPurchaseFlow = isInPurchaseFlow
        super.init(nibName: nil, bundle: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        isFavorite()
        super.viewDidAppear(animated)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    var activeTextField : UITextField? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configure()
        fetchRestaurant()
        scrollView.frame = self.view.bounds
        //commentTextField.becomeFirstResponder()
        commentTextField.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(RecipeInfoViewVC.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(RecipeInfoViewVC.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
           // if keyboard size is not available for some reason, dont do anything
           return
        }
      
      // move the root view up by the distance of keyboard height
      self.view.frame.origin.y = 0 - keyboardSize.height
    }
    @objc func keyboardWillHide(notification: NSNotification) {
      // move back the root view origin to zero
      self.view.frame.origin.y = 0
    }
    
    
    //MARK:- Helpers
    private func configure() {
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    private func configureUI() {
        view.backgroundColor = .backgroundGray
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        scrollView.addSubview(restarantImageView)
        restarantImageView.snp.makeConstraints { make in
            make.height.equalTo(view.frame.height * 0.4 * ratio)
            make.left.right.top.equalToSuperview()
        }
        
        scrollView.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(40 * ratio)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(10)
        }
        //MARK:- RestaurantInfo
        scrollView.addSubview(infoView)
        infoView.snp.makeConstraints { make in
            make.size.equalTo(view.frame.width-40)
            make.height.equalTo(130)
            make.top.equalTo(restarantImageView.snp.bottom).offset(-160)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        infoView.addSubview(restaurantLabel)
        restaurantLabel.snp.makeConstraints { make in
            make.top.equalTo(infoView).offset(15)
            make.left.equalTo(infoView).offset(20)
        }
        
        infoView.addSubview(locationIcon)
        locationIcon.snp.makeConstraints { make in
            make.size.equalTo(40 * ratio)
            make.top.equalTo(restaurantLabel.snp.bottom).offset(5)
            make.left.equalTo(infoView).offset(20)
        }
        
        infoView.addSubview(locationLabel)
        locationLabel.snp.makeConstraints { make in
            make.height.equalTo(40 * ratio)
            make.top.equalTo(restaurantLabel.snp.bottom).offset(5)
            make.left.equalTo(locationIcon.snp.right).offset(10)
            make.right.equalTo(infoView).offset(-20)
        }
        
        infoView.addSubview(phoneIcon)
        phoneIcon.snp.makeConstraints { make in
            make.size.equalTo(40)
            make.top.equalTo(locationLabel.snp.bottom)
            make.left.equalTo(infoView).offset(20)
        }
        
        infoView.addSubview(phoneLabel)
        phoneLabel.snp.makeConstraints { make in
            make.height.equalTo(40 * ratio)
            make.top.equalTo(locationLabel.snp.bottom)
            make.left.equalTo(phoneIcon.snp.right).offset(10)
            make.right.equalTo(infoView).offset(-20)
        }
        //MARK:- contentView
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.size.equalTo(view.frame.height * 0.4 * ratio)
            make.height.equalTo(310 * ratio)
            make.top.equalTo(infoView.snp.bottom).offset(12)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        
        contentView.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(40 * ratio)
            make.top.equalTo(contentView)
            make.left.equalTo(infoView).offset(10)
        }
        
        contentView.addSubview(recipeImageView)
        recipeImageView.snp.makeConstraints { make in
            make.height.equalTo(130 * ratio)
            //make.width.equalTo(150 * ratio)
            make.top.equalTo(titleLabel.snp.bottom)
            make.left.equalTo(contentView).offset(10)
            make.right.equalTo(contentView).offset(-10)
        }
        
        recipeImageView.addSubview(favoriteButton)
        favoriteButton.snp.makeConstraints { make in
            make.size.equalTo(40 * ratio)
            make.bottom.equalTo(recipeImageView.snp.bottom).offset(-10)
            make.right.equalTo(recipeImageView).offset(-10)
        }
        
        contentView.addSubview(cookTimeLabel)
        cookTimeLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeImageView.snp.bottom).offset(-5)
            make.centerX.equalTo(contentView)
        }
        
        contentView.addSubview(cookDifficultyLabel)
        cookDifficultyLabel.snp.makeConstraints { make in
            make.top.equalTo(cookTimeLabel.snp.bottom).offset(5)
            make.centerX.equalTo(contentView)
        }
                
        contentView.addSubview(purchaseButton)
        purchaseButton.snp.makeConstraints { make in
            make.height.equalTo(45 * ratio)
            make.top.equalTo(cookDifficultyLabel.snp.bottom).offset(10)
            make.bottom.equalTo(contentView).offset(-18)
            make.left.equalToSuperview().offset(50)
            make.right.equalToSuperview().offset(-50)
        }
        
        scrollView.addSubview(commentView)
        commentView.snp.makeConstraints { make in
            //make.width.equalTo(view.frame.width-40)
            make.height.equalTo(view.frame.width-10)
            //make.size.lessThanOrEqualTo(view.frame.height*0.4)
            make.top.equalTo(contentView.snp.bottom).offset(12)
            make.bottom.equalTo(scrollView).offset(-5)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }
        commentView.addSubview(commentTitleLabel)
        commentTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(commentView).offset(15)
            make.left.equalTo(commentView).offset(20)
        }
        commentView.addSubview(commentTextField)
        commentTextField.snp.makeConstraints { make in
            make.height.equalTo(36 * ratio)
            make.top.equalTo(commentTitleLabel.snp.bottom).offset(10)
            make.left.equalTo(commentView).offset(20)
        }
        commentView.addSubview(submitButton)
        submitButton.snp.makeConstraints { make in
            make.height.equalTo(35 * ratio)
            make.width.equalTo(55 * ratio)
            make.top.equalTo(commentTitleLabel.snp.bottom).offset(10)
            make.right.equalTo(commentView).offset(-30)
        }
        
        commentView.addSubview(tableView)
        tableView.snp.makeConstraints { make in
            make.top.equalTo(commentTitleLabel.snp.bottom).offset(50)
            make.left.equalToSuperview().offset(35)
            make.right.equalToSuperview().offset(-15)
            make.bottom.equalToSuperview().offset(-15)
        }
 
        /*
        tableView.addSubview(profileImageView)
        profileImageView.snp.makeConstraints { make in
            make.width.height.equalTo(50 * ratio)
            make.top.left.equalToSuperview().offset(15)
            //make.size.equalTo(view.frame.width-320)
            make.left.equalToSuperview().offset(15)
        }
        tableView.addSubview(userNameLabel)
        userNameLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(20)
            make.left.equalTo(profileImageView.snp.right).offset(30)
            
        }
        tableView.addSubview(commentLabel)
        commentLabel.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel).offset(25)
            make.left.equalTo(profileImageView.snp.right).offset(30)
            make.right.equalTo(commentView).offset(-20)
            
        }
        
        tableView.addSubview(thumbsUpButton)
        thumbsUpButton.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel).offset(70)
            make.right.equalTo(commentView).offset(-50)
        }
        tableView.addSubview(thumbsDownButton)
        thumbsDownButton.snp.makeConstraints { make in
            make.top.equalTo(userNameLabel).offset(70)
            make.right.equalTo(commentView).offset(-20)
        }
    
    */
    }
    private func fetchRestaurant() {
        guard let recipe = recipe else { return }
        API.fetchRestaurant(byName: recipe.restaurant) { [weak self] response in
            guard let strongSelf = self,
                  let url = response?.restaurantImageUrl
            else { return }
            strongSelf.restarantImageView.sd_setImage(with: url)
        }
    }
    
    //MARK:- Selectors
    @objc func pressPurchaseButton() {
        guard let restaurantName = recipe?.name,
              let payAmount = recipe?.price,
              let uid = recipe?.uid
        else { return }
        
        let vc = PurchaseVC(itemName: restaurantName, payAmount: payAmount, uid: uid)
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func buttonPressed() {
        favIsOn = !favIsOn
        if favIsOn {
            setFavorite()
        }
        else {
            unsetFavorite()
        }
    }
    
    func isFavorite() -> Void {
        let favoriteUid = User.shared.favorite
        guard let uid = recipe?.uid else { return }
        if favoriteUid.contains(uid) {
            favIsOn = true
            self.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }
        else {
            favIsOn = false
            self.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
        }
    }
    
    @objc func setFavorite(){
        API.setFavorite(recipe: recipe!) { [weak self] (error, ref) in
            guard let strongSelf = self else { return }
            if error != nil {
                print("Error: failed to set favorite")
            } else {
                strongSelf.favoriteButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            }
        }
    }
    
    @objc func unsetFavorite(){
        API.unsetFavorite(recipe: recipe!) { [weak self] (error, ref) in
            guard let strongSelf = self else { return }
            if error != nil {
                print("Error: failed to unset favorite")
            } else {
                strongSelf.favoriteButton.setImage(UIImage(systemName: "heart"), for: .normal)
            }
        }
    }
    @objc func commentTextFieldDidhange(_ textField: UITextField) {
        guard textField.text != nil else { return }
        //self.comment = comment

    }
}

extension RecipeInfoViewVC: UITableViewDataSource, UITableViewDelegate{
    // Deselect row
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10  //Choose your custom row number
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0;//Choose your custom row height
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! CommentCell
            return cell
    }
}
extension RecipeInfoViewVC : UITextFieldDelegate {
  // when user select a textfield, this method will be called
    func textFieldDidBeginEditing(_ textField: UITextField) {
    // set the activeTextField to the selected textfield
        self.activeTextField = textField
    }
    
    // when user click 'done' or dismiss the keyboard
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeTextField = nil
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text{
            print("\(text)")
        }
        
        return true
    }
}


