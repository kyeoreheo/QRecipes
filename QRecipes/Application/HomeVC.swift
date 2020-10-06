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
    let bigTitleLabel = UILabel()
    let navBar = UINavigationBar()
    
    var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.translatesAutoresizingMaskIntoConstraints = false
        cv.register(FeedCell.self, forCellWithReuseIdentifier: "cell")
        return cv
    } ()
  
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
        //navigationController?.isNavigationBarHidden = false
        //configureNavBar()
        configureUI()
    }
    
    //MARK:- Helpers
    private func configure() {
        view.backgroundColor = .white
    }
    
    private func configureNavBar() {
        navBar.delegate = self
        navBar.setItems([UINavigationItem(title: "Home")], animated: false)

        view.addSubview(navBar)
        navBar.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.right.equalToSuperview()
        }
    }
    
    private func configureUI() {
        
        view.addSubview(bigTitleLabel)
        
        bigTitleLabel.text = "POPULAR RECIPES"
        bigTitleLabel.textColor = UIColor(rgb: 0x424242)
        bigTitleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        
        bigTitleLabel.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(54)
            make.left.equalTo(view).offset(12)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(84)
            make.right.equalTo(view).offset(-12)
        }
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        view.addSubview(collectionView)
        
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.minimumLineSpacing = 20
        //layout.minimumInteritemSpacing = 20
        
        collectionView.backgroundColor = .white
        
        collectionView.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(94)
            make.left.equalTo(view).offset(16)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.right.equalTo(view).offset(-16)
        }
        

//        view.addSubview(sampleLable)
//        sampleLable.text = "This is a HomeTab"
//        sampleLable.textColor = .black
//        sampleLable.font = UIFont.systemFont(ofSize: 20)
//        sampleLable.snp.makeConstraints { make in
//            make.center.equalToSuperview()
//        }
    }
    
}

extension HomeVC: UINavigationBarDelegate {
    // Unified the status bar area with the nav bar
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}

extension HomeVC: UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (collectionView.frame.width-20)/2, height: (collectionView.frame.width)/2 )
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! FeedCell
        cell.titleLabel.text = "Cupcakes"

        return cell
    }
}
