//
//  ProductCollection.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 27.12.2023.
//

import UIKit

final class FavouriteCollection: UICollectionView {
    
    var detailDelegate: DetailViewCellDelegate?
    
    let networkManager = NetworkingManager()
    private var recipes: [Hit]? = [Hit]() {
        didSet {
            DispatchQueue.main.async {
                self.reloadData()
            }
        }
    }
    private var recipe: Hit?
    private var favouriteLinks: [String]?
    private let productLayout = UICollectionViewFlowLayout()

    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: productLayout)
        configure()
        fetchFavRecipesLinks()
//        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
//            self.fetchFavRecipes()
//        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension FavouriteCollection {
    func configure() {
        productLayout.minimumInteritemSpacing = 25
        productLayout.scrollDirection = .vertical
        
        showsVerticalScrollIndicator = false
        bounces = false
        backgroundColor = .none
        
        dataSource = self
        delegate = self
        
        networkManager.networkFavouriteDelegate = self
        
        register(ProductCollectionCell.self, forCellWithReuseIdentifier: "favouriteCell")
    }
    
    func fetchImage(_ stringURL: String, imageComplitionHandler: @escaping (UIImage?) -> Void) {
        guard let url = URL(string: stringURL) else { return }
        let _: Void = URLSession.shared.dataTask(with: url) { data, _, error in // why add (task: Void)
            if let data = data {
                let image = UIImage(data: data)
                imageComplitionHandler(image)
            }
        }.resume()
    }
    
    
    func fetchFavRecipesLinks() {
        DatabaseManager.shared.realtimeDatabase { recipesModel in
            guard let recipes = recipesModel?.favouriteRecipes else { return }
            self.favouriteLinks = recipes
            self.recipes?.removeAll()
            self.fetchFavRecipes()
        }
    }
    
    func fetchFavRecipes() {
        guard let recipeLinks = favouriteLinks else { return }
        for link in recipeLinks {
            self.networkManager.fetchRecipe(link)
        }
    }
}

//MARK: - UICollectionDataSource
extension FavouriteCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "favouriteCell", for: indexPath) as? ProductCollectionCell else { return UICollectionViewCell() }
        
        let recipe = recipes![indexPath.row]
        
        cell.title.text = recipe.recipe.label
        cell.selfLink = recipe._links.`self`.href
        cell.isFavouriteButton.tintColor = UIColor.red
        cell.layer.backgroundColor = R.Colors.backgroundSecond.cgColor
        
        fetchImage(recipe.recipe.image) { image in
            DispatchQueue.main.async {
                cell.image.image = image
            }
        }
        
        layer.shadowRadius = 2.0
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.10
        layer.shadowOffset = CGSize(width: 0, height: 2)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegate
extension FavouriteCollection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let recipe = recipes?[indexPath.row] {
            detailDelegate?.openDetailCell(recipeInfo: recipe)
        }
    }
}

//MARK: - UICollectionViewDelegateFlowLayout
extension FavouriteCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width, height: 110)
    }
}

extension FavouriteCollection: NetworkFavouriteDelegate {
    func didUpdateData(_ manager: NetworkingManager, recipe: Hit) {
        recipes = (recipes ?? []) + [recipe]
    }
}


