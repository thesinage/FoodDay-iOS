//
//  Favourite.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 23.12.2023.
//

import UIKit

final class Favourite: BaseController {
    
    private let categoryCollection = CategoryCollection()
    private let favouriteCollection  = FavouriteCollection()
    
    override func viewDidLoad() {
        setupViews()
        layoutView()
        configure()
    }
}

extension Favourite {
    override func setupViews() {
        view.setupView(categoryCollection)
        view.setupView(favouriteCollection)
    }
    override func layoutView() {
        NSLayoutConstraint.activate([
            categoryCollection.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            categoryCollection.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
            categoryCollection.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            categoryCollection.heightAnchor.constraint(equalToConstant: 40),
            
            favouriteCollection.topAnchor.constraint(equalTo: categoryCollection.bottomAnchor, constant: 20),
            favouriteCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            favouriteCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            favouriteCollection.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -10)
        ])
        
    }
    override func configure() {
        super.configure()
        title = R.Strings.Favourite.navTitle
        navigationController?.tabBarItem.title = R.Strings.TabBar.favourite
        navigationController?.navigationBar.prefersLargeTitles = true
        
        favouriteCollection.detailDelegate = self
        
        NotificationCenter.default.addObserver(self,
                                               selector: #selector(reloadDataWhenThemeChanged),
                                               name: Notification.Name("themeChanged"),
                                               object: nil)
    }
    
    @objc func reloadDataWhenThemeChanged() {
        DispatchQueue.main.async {
            self.favouriteCollection.reloadData()
        }
    }
}


extension Favourite: DetailViewCellDelegate {
    func openDetailCell(recipeInfo: Hit) {
        let detailViewController = DetailViewController()
        navigationController?.pushViewController(detailViewController, animated: true)
        
        favouriteCollection.fetchImage(recipeInfo.recipe.image) { image in
            DispatchQueue.main.async {
                detailViewController.imageView.image = image
            }
        }
        
        detailViewController.nameOfRecipe.text = recipeInfo.recipe.label
        detailViewController.ingredientLines = recipeInfo.recipe.ingredientLines
    }
}

