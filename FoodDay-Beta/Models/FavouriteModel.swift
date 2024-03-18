//
//  FavouriteModel.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 17.02.2024.
//

import Foundation

struct FavouriteModel: Codable {
    var favouriteRecipes: [String]
    
    enum CodingKeys: String, CodingKey {
        case favouriteRecipes
    }
}
