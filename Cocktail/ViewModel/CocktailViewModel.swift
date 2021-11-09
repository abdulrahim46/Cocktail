//
//  CocktailViewModel.swift
//  Cocktail
//
//  Created by Abdul Rahim on 09/11/21.
//

import Foundation
import Combine

class CocktailViewModel {
    
    // MARK: - Properties
    
    @Published var drinks: Drink?
    private var anyCancelable = Set<AnyCancellable>()
    
    var apiResource: DataProvider
    
    init(apiResource: DataProvider = NetworkManager()) {
        self.apiResource = apiResource
        fetchDrinks(query: "")
        unsubscribe()
    }
    
    private func unsubscribe() -> Void {
        anyCancelable.forEach {
            $0.cancel()
        }
        anyCancelable.removeAll()
    }
    
    
    /// fetching news from server
    func fetchDrinks(query: String?) {
        drinks = nil
        apiResource.getCocktails(query: query)
            .receive(on: DispatchQueue.main)
            .map{$0}
            .sink { completion in
                
                switch completion {
                case .finished:
                    print("Done")
                case .failure(let error):
                    print(error)
                }
            } receiveValue: { [weak self] drinks in
                print(drinks)
                self?.drinks = drinks
                
            }
            .store(in: &anyCancelable)
    }
    
    
}
