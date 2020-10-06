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

class SearchVC: UIViewController {
    //MARK:- Properties
    //private let sampleLable = UILabel()
    //let topLabel = UILabel()
    let navBar = UINavigationBar() //remove
    //let searchController = UISearchController(searchResultsController: nil)
    let searchBar = UISearchBar()
    let tableView = UITableView()
    var userArr = [UserModal]()
    //MARK:- LifeCycles
    override func viewDidLoad() {
        super.viewDidLoad()
        //configure()
        configureUI()
        configureNavBar()
        configureSearchBar()
        setTableView()
        
        userArr.append(UserModal(userImage:  #imageLiteral(resourceName: "salmon"), name: "Recipe: Salmon", restaurant: "Cheesecake Factory"))
        userArr.append(UserModal(userImage: #imageLiteral(resourceName: "pasta") , name: "Recipe: Pasta", restaurant: "Oliva Garden"))
        userArr.append(UserModal(userImage: #imageLiteral(resourceName: "Boeuf-bourguignon") , name: "Boeuf-bourguignon", restaurant: "Le Rivage"))
        userArr.append(UserModal(userImage:#imageLiteral(resourceName: "cheese-fries-1"), name: "Recipe: Cheese fries", restaurant: "Shake Shake"))
        userArr.append(UserModal(userImage: #imageLiteral(resourceName: "chicken-nuggets") , name: "Recipe: Chicken Nugget", restaurant: "McDonald"))
        userArr.append(UserModal(userImage: #imageLiteral(resourceName: "shushi") , name: "Recipe: Shushi", restaurant: "Tobiko"))
        userArr.append(UserModal(userImage: #imageLiteral(resourceName: "taco") , name: "Recipe: Taco", restaurant: "La Espiga"))
        //navigationItem.searchController = searchController
        //searchController.searchBar.delegate = self
        //setupTableView()
        //tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setTableView() {
        tableView.frame = self.view.frame
        tableView.backgroundColor = UIColor.clear
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
//      tableView.translatesAutoresizingMaskIntoConstraints = false
//      tableView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
//
//      tableView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
//      tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
//      tableView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    
    func configureSearchBar(){
        searchBar.searchBarStyle = UISearchBar.Style.prominent
        searchBar.placeholder = " Search..."
        searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        
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
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String)
    {
        print(textSearched)
    }
    
}
extension SearchVC: UINavigationBarDelegate {
    // Unified the status bar area with the nav bar
//    func position(for bar: UIBarPositioning) -> UIBarPosition {
//        return .topAttached
//    }
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
        //cell.nameLbl.text = userArr[indexPath.row].name
        //cell.restaurantLbl.text = userArr[indexPath.row].restaurant
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 118
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}

    /*
    @objc func handleShowSearchBar(){
        search(shouldShow: true)
        
        searchBar.becomeFirstResponder()
    }
 */
    //MARK:- Helpers

   /*
    func showSearchBarButton(shouldShow: Bool){
        
        if shouldShow{
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    func search(shouldShow: Bool){
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
//        internal func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String){
//             print(searchText)
//        }
//
//        private func configureNavBar() {
//            naviBar.delegate = self as? UINavigationBarDelegate
//               naviBar.setItems([UINavigationItem(title: "Search")], animated: false)
//
//               view.addSubview(naviBar)
//               naviBar.snp.makeConstraints { make in
//                   make.height.equalTo(44)
//                   make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
//                   make.left.right.equalToSuperview()
//               }
//           }
//        private func configureUI() {
//            view.addSubview(topLabel)
//            topLabel.text = "SEARCH POPULAR RECIPES"
//            topLabel.textColor = .black
//            topLabel.font = UIFont.systemFont(ofSize: 18)
//
//            topLabel.snp.makeConstraints { make in
//            make.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(54)
//            make.left.equalTo(view).offset(12)
//            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.top).offset(84)
//            make.right.equalTo(view).offset(-12)
//            }
//    }
    
    //MARK:- Selectors
    
 */

//
//extension SearchVC: UISearchBarDelegate{
//    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
//        search(shouldShow: false)
//    }
//}

