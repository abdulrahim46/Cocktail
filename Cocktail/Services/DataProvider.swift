//
//  DataProvider.swift
//  Cocktail
//
//  Created by Abdul Rahim on 09/11/21.
//

import Foundation
import Combine

protocol DataProvider {
    func getCocktails() -> AnyPublisher<Drink, NetworkManager.APIError>
}
