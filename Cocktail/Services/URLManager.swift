//
//  URLManager.swift
//  Cocktail
//
//  Created by Abdul Rahim on 09/11/21.
//

import Foundation

struct URLManager {
    
    static let kBaseURL = "https://saurav.tech"
    static let kGetNewsEverything = "/NewsAPI/everything/cnn.json"
    
    static func getUrlString(for serviceEnum: ServiceURLType)-> String {
        switch serviceEnum {
        case .news:
            return kBaseURL + kGetNewsEverything
        default:
            return kBaseURL + kGetNewsEverything
        }
    }
    
}


enum ServiceURLType {
    case news
    case details
}
