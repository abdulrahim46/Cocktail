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
    
    enum CodingKeys: String, CodingKey {
        case category = "strCategory"
        case image = "strDrinkThumb"
        case drink = "strDrink"
    }
}
