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
    
    let searchBar = UISearchBar()//stack frame[text data, heap stack.....]
    let tableView = UITableView()
    let lbl = UILabel()
    
    //Once we fetched, this keeps the all the recipes on database. and never changed. It fetches in here fetchRecipes()
    var fullRecipes = [Recipe]()
    //This recipes can be changed based on search key
    var recipes = [Recipe]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    //MARK:- LifeCycles
    override func viewDidLoad() { //running time
        super.viewDidLoad()
        
        configureUI()
        configureSearchBar()
        setTableView()
        fetchRecipes()
    }

    func setTableView() {
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
        //searchBar.sizeToFit()
        searchBar.isTranslucent = false
        searchBar.delegate = self
        searchBar.barTintColor = UIColor.white
        searchBar.tintColor = UIColor.orange
        searchBar.barStyle = .black
        view.addSubview(searchBar)
        searchBar.snp.makeConstraints { make in
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.left.equalTo(view)
            make.right.equalTo(view)
        }
    }
    
    private func configureUI() {
        view.backgroundColor = .white
    }
    
    func fetchRecipes() {
        API.fetchRecipes { recipes in
            self.recipes = recipes
            self.fullRecipes = recipes
        }
    }
    /*
    @objc func handleShowSearchBar() {
           searchBar.becomeFirstResponder()
           search(shouldShow: true)
       }
    func showSearchBarButton(shouldShow: Bool) {
        if shouldShow {
            navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .search,
                                                                target: self,
                                                                action: #selector(handleShowSearchBar))
        } else {
            navigationItem.rightBarButtonItem = nil
        }
    }
    func search(shouldShow: Bool) {
        showSearchBarButton(shouldShow: !shouldShow)
        searchBar.showsCancelButton = shouldShow
        navigationItem.titleView = shouldShow ? searchBar : nil
    }
 */
}

extension SearchVC: UISearchBarDelegate{
    func searchBar(_ searchBar: UISearchBar, textDidChange textSearched: String){
        guard let searchKey = searchBar.text?.lowercased() else { return }
        if searchKey == "" {
            recipes = fullRecipes
        } else {
            recipes = fullRecipes.filter { recipe in
                recipe.tags.contains { tag in
                    tag.contains(searchKey)
                }
            }
        }
    }
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        print("Search bar editing did begin..")
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        searchBar.showsCancelButton = true
        print("Search bar editing did end..")
        searchBar.resignFirstResponder()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        searchBar.showsCancelButton = false
        searchBar.resignFirstResponder()
        tableView.reloadData()
        recipes = fullRecipes
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        //searchBar.resignFirstResponder()
        searchBar.text = ""
        searchBar.endEditing(true)
    }
    
    // MARK: - Navigation and pass data
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = RecipeInfoViewVC()
        vc.recipe = recipes[indexPath.row]
        navigationController?.pushViewController(vc, animated: true)
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
        return recipes.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as?
        //cell.textLabel?.text = "\(indexPath.row)"
        
        CustomTableViewCell else {fatalError("Unable to create cell")}
        let imageView = UIImageView()
        imageView.sd_setImage(with: recipes[indexPath.row].recipeImageUrl)
        cell.userImage.image = imageView.image
        cell.nameLbl.text = recipes[indexPath.row].name
        cell.restaurantLbl.text = recipes[indexPath.row].restaurant
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 130
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollView.delegate = self
        //scrollView.contentSize = CGSize(width:self.view.frame.size.width, height: 1000)
        searchBar.resignFirstResponder()
    }
}
