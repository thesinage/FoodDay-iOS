//
//  ProductCollection.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 27.12.2023.
//

import UIKit


protocol DetailViewCellDelegate {
    func openDetailCell(recipeInfo: Hit)
}

final class ProductCollection: UICollectionView {
    
    var detailDelegate: DetailViewCellDelegate?
    
    var loadMoreStatus = false
    let networkManager = NetworkingManager()
    private var recipes: RecipesModel?
    private let productLayout = UICollectionViewFlowLayout()
    
    override init(frame: CGRect, collectionViewLayout layout: UICollectionViewLayout) {
        super.init(frame: frame, collectionViewLayout: productLayout)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ProductCollection {
    func configure() {
        productLayout.minimumInteritemSpacing = 25
        productLayout.scrollDirection = .vertical
        
        showsVerticalScrollIndicator = false
        bounces = false
        backgroundColor = .none
        
        dataSource = self
        delegate = self
        networkManager.delegate = self
        networkManager.nextLoadDelegate = self
        
        
        register(ProductCollectionCell.self, forCellWithReuseIdentifier: "productCell")
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
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let currentOffSet = scrollView.contentOffset.y
        let maximumOffSet = scrollView.contentSize.height - scrollView.frame.size.height
        let deltaOffSet = maximumOffSet - currentOffSet
        
        if deltaOffSet <= 0 {
            loadMore()
        }
    }
    func loadMore() {
        if !(loadMoreStatus) {
            self.loadMoreStatus = true
            loadMoreBegin { [self] _ in
                loadMoreStatus = false
            }
        }
    }
    func loadMoreBegin(loadMoreEnd: @escaping (Bool) -> ()) {
        DispatchQueue.global().async {
            if let path = self.recipes?._links.next.href {
                self.networkManager.fetchNextRecipes(path)
            }
            
            DispatchQueue.main.async {
                loadMoreEnd(false)
            }
        }
    }
    
    func setColor(_ link: String, complition: @escaping (UIColor) -> Void)  {
        DatabaseManager.shared.getPost { recipesModel in
            guard let x = recipesModel?.favouriteRecipes else { return }
            for recipe in x {
                if recipe == link {
                    complition(UIColor.red)
                } else {
                    complition(UIColor.gray)
                }
            }
        }
    }
}

//MARK: - UICollectionViewDataSource
extension ProductCollection: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recipes?.hits.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "productCell", for: indexPath) as? ProductCollectionCell else { return UICollectionViewCell() }
        
        let recipe = recipes!.hits[indexPath.row]
        
        cell.layer.backgroundColor = R.Colors.backgroundSecond.cgColor
        cell.title.text = recipe.recipe.label
        cell.selfLink = recipe._links.`self`.href
        
        
//        setColor(cell.selfLink) { color in
//                cell.isFavouriteButton.tintColor = color
//            }
        
        fetchImage(recipe.recipe.image) { image in
            DispatchQueue.main.async {
                cell.image.image = image
            }
        }
        
        cell.buttonTapped = { [unowned self] in
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) {
                self.reloadData()
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
extension ProductCollection: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let recipe = recipes?.hits[indexPath.row] {
            detailDelegate?.openDetailCell(recipeInfo: recipe)
        }
    }
}
//MARK: - UICollectionViewDelegateFlowLayout
extension ProductCollection: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: frame.width, height: 110)
    }
}

//MARK: - NetworkManagerDelegate
extension ProductCollection: NetworkingManagerDelegate, NetworkingManagerAppendDelegate {
    func didUpdateData(_ manager: NetworkingManager, recipes: RecipesModel) {
        self.recipes = recipes
        DispatchQueue.main.sync {
            self.reloadData()
        }
    }
    
    func loadNextRecipes(_ manager: NetworkingManager, recipes: RecipesModel) {
        self.recipes?._links.next.href = recipes._links.next.href
        for recipe in recipes.hits {
            self.recipes?.hits.append(recipe)
        }
        DispatchQueue.main.async {
            self.reloadData()
        }
    }
}
