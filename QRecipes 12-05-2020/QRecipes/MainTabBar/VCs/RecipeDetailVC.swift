//
//  RecipeDetailVC.swift
//  QRecipes
//
//  Created by Yiheng Cen Feng on 10/17/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class RecipeDetailVC: UIViewController {
    //MARK:- Properties
    
    var recipe: Recipe? {
        didSet {
            imageView.sd_setImage(with: recipe?.recipeImageUrl, completed: nil)
            recipeLabel.text = recipe?.name
            restaurantLabel.text = recipe?.restaurant
            timeLabel.text = recipe?.cookTime
            levelLabel.text = recipe?.level
        
            IngredientsContainer.ingredients = recipe?.ingredients ?? [""]
        }
    }
    
    var segmentedControl: UISegmentedControl = {
        let control = UISegmentedControl(items: ["Ingredients", "Instructions"])
        control.setTitleTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.black], for: UIControl.State.normal)
        control.selectedSegmentIndex = 0
        control.addTarget(self, action: #selector(selectionDidChange), for: .valueChanged)
        control.backgroundColor = .white
        control.selectedSegmentTintColor = .white
        return control
    }()
    
    private lazy var IngredientsContainer: IngredientsVC = {
        let vc = IngredientsVC()
        self.add(asChildViewController: vc)
        return vc
    }()
    
    private lazy var InstructionsContainer: InstructionsVC = {
        let vc = InstructionsVC()
        self.add(asChildViewController: vc)
        return vc
    }()
    
    var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()

    var backButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .clear
        button.addTarget(self, action: #selector(popVC), for: .touchUpInside)
        button.setImage(UIImage(named: "arrow-left"), for: .normal)
        button.contentMode = .scaleAspectFit
        return button
    }()
    
    var imageView: UIImageView = {
        let img = UIImageView()
        img.contentMode = .scaleAspectFill
        img.clipsToBounds = true
        img.image = UIImage(named: "cupcakes")
        return img
    }()

    var recipeLabel: UILabel = {
        let label = UILabel()
        label.text = "Strawberry Cupcakes"
        label.textColor = .primeOrange
        label.font = UIFont.boldSystemFont(ofSize: 28)
        label.numberOfLines = 0
        return label
    }()

    var restaurantLabel: UILabel = {
        let label = UILabel()
        label.text = "Yummy Dessert Shop"
        label.textColor = .gray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()

    var timeLabel: UILabel = {
        let label = UILabel()
        label.text = "60 min"
        label.textColor = .charcoalBlack
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    var levelLabel: UILabel = {
        let label = UILabel()
        label.text = "Easy"
        label.textColor = .charcoalBlack
        label.font = UIFont.boldSystemFont(ofSize: 14)
        return label
    }()
    
    var dividerLabel: UILabel = {
        let label = UILabel()
        label.text = "|"
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 20)
        return label
    }()
    
    var timeIcon: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .primeOrange
        button.setImage(UIImage(systemName: "timer"), for: .normal)
        return button
    }()
    
    var levelIcon: UIButton = {
        let button = UIButton(type: .custom)
        button.tintColor = .systemGreen
        button.setImage(UIImage(systemName: "circle.fill"), for: .normal)
        return button
    }()

    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupDefaultSegmentedControl()
    }

    //MARK:- Helpers
    private func setupDefaultSegmentedControl(){
        add(asChildViewController: IngredientsContainer)
    }
    
    private func configureUI() {
        view.backgroundColor = .white

        view.addSubview(imageView)
        imageView.snp.makeConstraints { make in
            make.height.equalTo(view.frame.height*0.4)
            make.left.right.top.equalToSuperview()
        }

        view.addSubview(backButton)
        backButton.snp.makeConstraints { make in
            make.width.height.equalTo(40)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            make.left.equalToSuperview().offset(10)
        }

        view.addSubview(recipeLabel)
        recipeLabel.snp.makeConstraints { make in
            make.top.equalTo(imageView.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
            make.right.equalToSuperview().offset(-20)
        }

        view.addSubview(restaurantLabel)
        restaurantLabel.snp.makeConstraints { make in
            make.top.equalTo(recipeLabel.snp.bottom)
            make.left.equalToSuperview().offset(22)
            make.right.equalToSuperview().offset(-20)
        }
        
        view.addSubview(timeIcon)
        timeIcon.snp.makeConstraints { make in
            make.size.equalTo(20)
            make.top.equalTo(restaurantLabel.snp.bottom).offset(10)
            make.left.equalToSuperview().offset(20)
        }

        view.addSubview(timeLabel)
        timeLabel.snp.makeConstraints { make in
            make.top.equalTo(timeIcon.snp.top)
            make.left.equalTo(timeIcon.snp.right).offset(10)
            make.right.lessThanOrEqualTo(view.frame.width/2)
        }
        
        view.addSubview(dividerLabel)
        dividerLabel.snp.makeConstraints { make in
            make.top.equalTo(restaurantLabel.snp.bottom).offset(5)
            make.left.equalTo(timeLabel.snp.right).offset(20)
        }
        
        view.addSubview(levelIcon)
        levelIcon.snp.makeConstraints { make in
            make.size.equalTo(10)
            make.top.equalTo(timeIcon.snp.top).offset(3)
            make.left.equalTo(dividerLabel.snp.right).offset(20)
        }

        view.addSubview(levelLabel)
        levelLabel.snp.makeConstraints { make in
            make.top.equalTo(timeLabel.snp.top)
            make.left.equalTo(levelIcon.snp.right).offset(15)
            make.right.lessThanOrEqualToSuperview()
        }
        
        view.addSubview(segmentedControl)
        segmentedControl.snp.makeConstraints { make in
            make.height.equalTo(50)
            make.top.equalTo(dividerLabel.snp.bottom).offset(15)
            make.left.right.equalToSuperview()
        }
        
        view.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.size.lessThanOrEqualTo(view.frame.height*0.4)
            make.top.equalTo(segmentedControl.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }

    @objc func popVC() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func selectionDidChange(sender: UISegmentedControl) {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: InstructionsContainer)
            add(asChildViewController: IngredientsContainer)
        } else {
            remove(asChildViewController: IngredientsContainer)
            add(asChildViewController: InstructionsContainer)
        }
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify child view controller
        viewController.willMove(toParent: nil)

        viewController.view.removeFromSuperview()

        // Notify child view controller
        viewController.removeFromParent()
    }
    
    private func add(asChildViewController vc: UIViewController) {
        addChild(vc)
        
        contentView.addSubview(vc.view)

        vc.view.frame = contentView.bounds
        vc.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify child view controller
        vc.didMove(toParent: self)
    }
}
