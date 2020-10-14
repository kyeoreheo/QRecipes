//
//  HomeVC.swift
//  QRecipes
//
//  Created by Kyo on 9/14/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class HomeVC: UIViewController, UIGestureRecognizerDelegate {
    //MARK:- Properties
    let inset: CGFloat = 15.0
        
    lazy var titleLabel: UILabel = {
       let label = UILabel()
       label.text = "Trending"
       label.textColor = .black
       label.font = UIFont.boldSystemFont(ofSize: 28)
       return label
    }()
       
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        cv.backgroundColor = .white
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(FeedCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    } ()
  
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        configureUI()
    }
    
    //MARK:- Helpers
    private func configure() {
        collectionView.delegate = self
        collectionView.dataSource = self
    }
    
    private func configureUI() {
        view.backgroundColor = .white
        
        view.addSubview(titleLabel)
        titleLabel.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view).offset(12)
        }

        view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.left.right.equalToSuperview()
        }
    }
    
    // MARK: - Navigation and pass data
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("Selected Row \(indexPath.row)")
        let vc = RestaurantOverviewVC()
        navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK:- Collection view data source
extension HomeVC: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeedCell
        
        cell.restaurantLabel.text = "Yummy Dessert Shop"
        cell.recipeLabel.text = "Cupcakes"

        return cell
    }
}

//MARK:- Collection view layout
extension HomeVC: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width)
        return CGSize(width: width, height: width)
    }

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return inset
    }
}
