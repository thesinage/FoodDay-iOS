//
//  RecipesModelTwo.swift
//  FoodDay-Beta
//
//  Created by Николай Мавлютов on 05.02.2024.
//

import Foundation

struct RecipesModel: Codable {
    var hits: [Hit]
    var _links: NextData
    enum CodingKeys: String, CodingKey {
        case hits
        case _links
    }
}
 
struct NextData: Codable {
    var next: NextLink
    
    enum CodingKeys: String, CodingKey {
        case next
    }
}

struct NextLink: Codable {
    var href: String
    
    enum CodingKeys: String, CodingKey {
        case href
    }
}




//MARK: - Hits
struct Hit: Codable {
    var recipe: Recipe
    let _links: HitLinks
    
    enum CodingKeys: String, CodingKey {
        case recipe
        case _links
    }
}

struct Recipe: Codable {
    let label: String
    let image: String
    let url: String
    let ingredientLines: [String]
    
    enum CodingKeys: String, CodingKey {
        case label
        case image
        case url
        case ingredientLines
    }
}

struct HitLinks: Codable {
    let `self`: SelfLink
    
    enum CodingKeys: String, CodingKey {
        case `self`
    }
}

struct SelfLink: Codable {
    let href: String
}
