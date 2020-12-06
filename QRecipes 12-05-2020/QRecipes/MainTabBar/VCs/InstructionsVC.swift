//
//  InstructionsVC.swift
//  QRecipes
//
//  Created by Yiheng Cen Feng on 10/19/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class InstructionsVC: UIViewController {
    //MARK:- Properties
    var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.contentSize.width = 300;
        return view
    }()
    
    var instructionsLabel: UILabel = {
        let label = UILabel()
        label.text = "Gather your cupcake ingredients. Preheat oven to 325°F. Place paper baking cups in 24 regular-size muffin cups. In large bowl, mix the flour, granulated sugar and salt with a whisk. Set aside. Using a one-quart saucepan, heat one cup of butter, water, and three tablespoons of baking cocoa to boiling. Remove from heat and pour into flour mixture. Mix to combine. Add buttermilk, baking soda, vanilla, bourbon and eggs. Mix well to combine and then fold in chopped pecans. Divide the batter evenly among muffin cups, filling them two-thirds full. Bake for 20 to 25 minutes."
        label.textColor = .darkGray
        label.font = UIFont.systemFont(ofSize: 16)
        label.textAlignment = .justified
        label.numberOfLines = 0
        label.sizeToFit()
        return label
    }()

    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        scrollView.frame = view.bounds
    }
    
    //MARK:- Helpers
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.bottom.left.right.equalToSuperview()
        }
        
        scrollView.addSubview(instructionsLabel)
        instructionsLabel.snp.makeConstraints { make in
            make.top.left.equalToSuperview().offset(20)
            make.bottom.lessThanOrEqualToSuperview().offset(-20)
            make.right.equalTo(view).offset(-20)
        }
    }
}
