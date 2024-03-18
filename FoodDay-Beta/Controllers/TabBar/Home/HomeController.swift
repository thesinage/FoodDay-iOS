//
//  HomeController.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 23.12.2023.
//

import UIKit

final class HomeController: BaseController {
    
    let searchBar = SearchBarTextField()
    let categoryCollection = CategoryCollection()
    let productCollection = ProductCollection()
    
    override func viewDidLoad() {
        setupViews()
        layoutView()
        configure()
        
        searchBar.searchBarDelegate = self
        categoryCollection.categoryCollectionSelectDelegate = self
        productCollection.detailDelegate = self
    }
    
}

extension HomeController {
    override func setupViews() {
        view.setupView(categoryCollection)
        view.setupView(searchBar)
        view.setupView(productCollection)
    }
    override func layoutView() {
        NSLayoutConstraint.activate([
            searchBar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            searchBar.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant:  20),
            searchBar.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            searchBar.heightAnchor.constraint(equalToConstant: 40),
            
            categoryCollection.topAnchor.constraint(equalTo: searchBar.bottomAnchor, constant: 20),
            categoryCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            categoryCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            categoryCollection.heightAnchor.constraint(equalToConstant: 40),
            
            productCollection.topAnchor.constraint(equalTo: categoryCollection.bottomAnchor, constant: 20),
            productCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            productCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            productCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
    }
    override func configure() {
        super.configure()
        title = R.Strings.Home.navTitle
        navigationController?.tabBarItem.title = R.Strings.TabBar.home
        
        navigationController?.navigationBar.prefersLargeTitles = true
        
        productCollection.networkManager.fetchRecipes()
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadDataWhenThemeChanged),
                                               name: Notification.Name("themeChanged"),
                                               object: nil)
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadDataWhenThemeChanged),
                                               name: NSNotification.Name("favButtonTapped"),
                                               object: nil)
    }
    
    @objc func reloadDataWhenThemeChanged() {
        DispatchQueue.main.async {
            self.productCollection.reloadData()
        }
    }
    }

extension HomeController: SearchBarTextFieldEndInput {
    func getRequsteWithParameter(_ parametr: String) {
        productCollection.scrollToItem(at: [0, 0], at: .centeredVertically, animated: false)
        productCollection.networkManager.fetchRecipes(search: parametr)
        categoryCollection.selectItem(at: [0, 0], animated: false, scrollPosition: [])
    }
}

extension HomeController: CategoryCollectionSelectMealType {
    func mealTypeSelected(_ type: String) {
        productCollection.scrollToItem(at: [0, 0], at: .centeredVertically, animated: false)
        if searchBar.text == nil {
            productCollection.networkManager.fetchRecipes(search: type)
        } else {
            searchBar.text = ""
            productCollection.networkManager.fetchRecipes(search: type)
        }
    }
}


extension HomeController: DetailViewCellDelegate {
    func openDetailCell(recipeInfo: Hit) {
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
        
        productCollection.fetchImage(recipeInfo.recipe.image) { image in
            DispatchQueue.main.async {
                detailViewController.imageView.image = image
            }
        }
        
        detailViewController.nameOfRecipe.text = recipeInfo.recipe.label
        detailViewController.ingredientLines = recipeInfo.recipe.ingredientLines
    }
}
