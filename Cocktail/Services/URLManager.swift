//
//  URLManager.swift
//  Cocktail
//
//  Created by Abdul Rahim on 09/11/21.
//

import Foundation

struct URLManager {
    
    static let kBaseURL = "https://thecocktaildb.com"
    static let kGetEverything = "/api/json/v1/1/search.php?s="
    
    static func getUrlString(for serviceEnum: ServiceURLType) -> String {
        switch serviceEnum {
        case .drinks:
            return kBaseURL + kGetEverything
        case .query(let query):
            return kBaseURL + kGetEverything + query
            
        }
    }
    
}


enum ServiceURLType {
    case drinks
    case query(String)
}
