//
//  APIMockResources.swift
//  CocktailTests
//
//  Created by Abdul Rahim on 09/11/21.
//

import Foundation
import Combine

@testable import Cocktail

struct ApiMockResources: DataProvider {
    
    /// mock func for get news
    func getCocktails(query: String?) -> AnyPublisher<Drink, NetworkManager.APIError> {
        let drinks = [Drinks(category: "cocktail", image: "www.gogkgkngm.com", drink: "mojito", instruction: "stir not shaken", ingredient1: "leaves", ingredient2: "ice", ingredient3: "lots of ice", ingredient4: "lemon", ingredient5: "spices"),
                      Drinks(category: "cocktail", image: "www.gogkgkngm.com", drink: "mojito2", instruction: "stir not shaken", ingredient1: "leaves", ingredient2: "ice", ingredient3: "lots of ice", ingredient4: "lemon", ingredient5: "spices"),
                      Drinks(category: "cocktail", image: "www.gogkgkngm.com", drink: "mojito3", instruction: "stir not shaken", ingredient1: "leaves", ingredient2: "ice", ingredient3: "lots of ice", ingredient4: "lemon", ingredient5: "spices")]
        
        let data = Drink(drinks: drinks)
        return Just(data)
            .setFailureType(to: NetworkManager.APIError.self)
            .eraseToAnyPublisher()
    }
    
    
}
