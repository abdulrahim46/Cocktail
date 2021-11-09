//
//  Drink.swift
//  Cocktail
//
//  Created by Abdul Rahim on 09/11/21.
//

import Foundation

struct Drink: Codable {
    let drinks: [Drinks]
    
    enum CodingKeys: String, CodingKey {
        case drinks = "drinks"
    }
}

struct Drinks: Codable {
    let category: String?
    let image: String?
    let drink: String?
    let instruction: String?
    let ingredient1: String?
    let ingredient2: String?
    let ingredient3: String?
    let ingredient4: String?
    let ingredient5: String?
    
    enum CodingKeys: String, CodingKey {
        case category = "strCategory"
        case image = "strDrinkThumb"
        case drink = "strDrink"
        case instruction = "strInstructions"
        case ingredient1 = "strIngredient1"
        case ingredient2 = "strIngredient2"
        case ingredient3 = "strIngredient3"
        case ingredient4 = "strIngredient4"
        case ingredient5 = "strIngredient5"
    }
}
