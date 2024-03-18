//
//  NetworkingManager.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 03.02.2024.
//

import Foundation

protocol NetworkingManagerDelegate {
    func didUpdateData(_ manager: NetworkingManager, recipes: RecipesModel)
}
protocol NetworkingManagerAppendDelegate {
    func loadNextRecipes(_ manager: NetworkingManager, recipes: RecipesModel)
}

protocol NetworkFavouriteDelegate {
    func didUpdateData( _ manager: NetworkingManager, recipe: Hit)
}


class NetworkingManager: ObservableObject {
    
    var delegate: NetworkingManagerDelegate?
    var nextLoadDelegate: NetworkingManagerAppendDelegate?
    var networkFavouriteDelegate: NetworkFavouriteDelegate?
    
    private let recipesApi = "https://api.edamam.com/api/recipes/v2?type=public&"
    private let appId = "f5b6c510"
    private let appKey = "7891fcd950f3819ef12339ffa282bb01"
    
    func fetchRecipes(search: String = "pie") {
        let stringUrl = recipesApi + "q=\(search)" + "&app_id=\(appId)" + "&app_key=\(appKey)" + "&imageSize=REGULAR"
        performRequest(url: stringUrl)
    }
    
    func fetchNextRecipes(_ link: String) {
        nextPerformRequest(url: link)
    }
    
    func performRequest(url: String) {
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            let recipes = parseJSON(recipesData: data!)
            delegate?.didUpdateData(self, recipes: recipes)
        }
        task.resume()
    }
    
    func nextPerformRequest(url: String) {
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            let recipes = parseJSON(recipesData: data!)
            nextLoadDelegate?.loadNextRecipes(self, recipes: recipes)
        }
        task.resume()
    }
    
    func fetchRecipe(_ url: String) {
        guard let url = URL(string: url) else { return }
        
        let task = URLSession.shared.dataTask(with: url) { [self] (data, response, error) in
            let recipe = parseSimpleJSON(hitData: data!)
            networkFavouriteDelegate?.didUpdateData(self, recipe: recipe)
        }
        task.resume()
    }
    
    func parseJSON(recipesData: Data) -> RecipesModel {
        let decodedData = try! JSONDecoder().decode(RecipesModel.self, from: recipesData)
        
        let nextData = decodedData._links
        
        var recipesArray: [Hit] = [Hit]()
        
        for item in decodedData.hits {
            let label = item.recipe.label
            let image = item.recipe.image
            let url = item.recipe.url
            let ingredientLines = item.recipe.ingredientLines
            let selfLink = item._links.`self`.href
            
            recipesArray.append(Hit(recipe: Recipe(label: label,
                                                   image: image,
                                                   url: url,
                                                   ingredientLines: ingredientLines),
                                    _links: HitLinks(self: SelfLink(href: selfLink))))
        }
        
        return RecipesModel(hits: recipesArray, _links: nextData)
    }
    
    func parseSimpleJSON(hitData: Data) -> Hit {
        let decodedData = try! JSONDecoder().decode(Hit.self, from: hitData)
        let selfLink = decodedData._links.`self`.href
        return Hit(recipe: Recipe(label: decodedData.recipe.label,
                                  image: decodedData.recipe.image,
                                  url: decodedData.recipe.url,
                                  ingredientLines: decodedData.recipe.ingredientLines),
                   _links: HitLinks(self: SelfLink(href: selfLink)))
    }
}
