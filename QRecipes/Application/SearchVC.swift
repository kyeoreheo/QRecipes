//  SearchVC.swift
//  QRecipes
//
//  Created by Kyo on 9/14/20.
//  Copyright © 2020 Kyo. All rights reserved.
//

import UIKit
import SnapKit

class UserModal {
    var userImage: UIImage?
    var name: String?
    var restaurant: String?
    
    init(userImage: UIImage, name: String, restaurant: String) {
        self.userImage = userImage
        self.name = name
        self.restaurant = restaurant
    }
}

class SearchVC: UIViewController{
    //MARK:- Properties
    //private let sampleLable = UILabel()
    let navBar = UINavigationBar() //remove
    //let searchController = UISearchController(searchResultsController: nil)
    let searchBar = UISearchBar()
    let tableView = UITableView()
    let lbl = UILabel()
    
    var userArr = [UserModal]()
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        //configure()
        configureUI()
        configureNavBar()
        configureSearchBar()
        setTableView()
        
        userArr.append(UserModal(userImage: #imageLiteral(resourceName: "salmon"), name: "Recipe: Salmon", restaurant: "Restaurant: Cheesecake Factory"))
        userArr.append(UserModal(userImage:  #imageLiteral(resourceName: "pasta"), name: "Recipe: Pasta", restaurant: "Restaurant: Oliva Garden"))
        userArr.append(UserModal(userImage:  #imageLiteral(resourceName: "Boeuf-bourguignon"), name: "Recipe: Boeuf-bourguignon", restaurant: "Restaurant: Le Rivage"))
        userArr.append(UserModal(userImage:  #imageLiteral(resourceName: "cheese-fries-1"), name: "Recipe: Cheese fries", restaurant: "Restaurant: Shake Shake"))
        userArr.append(UserModal(userImage:  #imageLiteral(resourceName: "chicken-nuggets"), name: "Recipe: Chicken Nugget", restaurant: "Restaurant: McDonald"))
        userArr.append(UserModal(userImage:  #imageLiteral(resourceName: "shushi"), name: "Recipe: Shushi", restaurant: "Restaurant: Tobiko"))
        userArr.append(UserModal(userImage:  #imageLiteral(resourceName: "taco"), name: "Recipe: Taco", restaurant: "Restaurant: La Espiga"))
        
    }

    func setTableView() {
        
        tableView.frame = self.view.frame
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorColor = UIColor.clear
        tableView.backgroundColor = UIColor.white
        
        view.addSubview(tableView)
        
        tableView.register(CustomTableViewCell.self, forCellReuseIdentifier: "Cell")
        
        tableView.snp.makeConstraints { make in
            make.top.equalTo(searchBar.snp.bottom)
            make.left.equalTo(view)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom)
            make.right.equalTo(view)
        }

    }
    
    
    func configureSearchBar(){
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.setShowsCancelButton(true, animated: false)
        
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(navBar.snp.bottom)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
    }
    func configureNavBar() {
        navBar.delegate = self
        navBar.setItems([UINavigationItem(title: "Search")], animated: false)

        view.addSubview(navBar)
        navBar.snp.makeConstraints { make in
            make.height.equalTo(44)
            make.top.equalToSuperview()
            make.left.right.equalToSuperview()
        }
    }
    private func configureUI() {
        view.backgroundColor = .white
    }
}

extension SearchVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String){
        
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        //searchBar.showsCancelButton = false
        searchBar.resignFirstResponder() // turn off the keyboard

        searchBar.endEditing(true)
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        
        searchBar.resignFirstResponder()
    }
    
}

extension SearchVC: UINavigationBarDelegate {
     //Unified the status bar area with the nav bar
    func position(for bar: UIBarPositioning) -> UIBarPosition {
        return .topAttached
    }
}
extension SearchVC: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as?
        //cell.textLabel?.text = "\(indexPath.row)"
        
        CustomTableViewCell else {fatalError("Unable to create cell")}
        cell.userImage.image = userArr[indexPath.row].userImage
        cell.nameLbl.text = userArr[indexPath.row].name
        cell.restaurantLbl.text = userArr[indexPath.row].restaurant
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width:self.view.frame.size.width, height: 1000)
        searchBar.resignFirstResponder()
    }
}
