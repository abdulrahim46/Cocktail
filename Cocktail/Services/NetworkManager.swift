//
//  NetworkManager.swift
//  Cocktail
//
//  Created by Abdul Rahim on 09/11/21.
//

import Foundation
import Combine
import Network
import UIKit

class NetworkManager: DataProvider {
    
    //static let shared = NetworkManager()
    var anyCancelable = Set<AnyCancellable>()
    
    
    // get all news from api
    func getCocktails(query: String? = nil) -> AnyPublisher<Drink, APIError> {
        checkNetworkConnectivity()
        
        let urlString = URLManager.getUrlString(for: .drinks)
        let url = URL(string: urlString)
        let decoder = JSONDecoder()
        
        return Future { [weak self] promise in
            guard let self = self else { return }
            URLSession.shared.dataTaskPublisher(for: url!)
                .retry(1)
                .mapError { $0 }
                .tryMap { element -> Data in
                    guard let httpResponse = element.response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
                        throw URLError(.badServerResponse)
                    }
                    return element.data
                }
                .decode(type: Drink.self, decoder: decoder)
                .receive(on: DispatchQueue.main)
                .sink { _ in } receiveValue: { jobs in
                    promise(.success(jobs))
                }
                .store(in: &self.anyCancelable)
        }
        .eraseToAnyPublisher()
    }
    
    //checking network connectivity
    func checkNetworkConnectivity() {
        let monitor = NWPathMonitor()
        monitor.start(queue: .global())
        
        monitor.pathUpdateHandler = { path in
            if path.status == .satisfied {
                // do something here
            } else {
                DispatchQueue.main.async {
                    if let topVC = UIApplication.getTopMostViewController() {
                        if let _ = topVC as? UIAlertController {
                            return
                        }
                        Alert.showErrorAlertWithMsg(title: Constants.ErrorMessage.kNoInternetTitle, msg: Constants.ErrorMessage.kConnectivityError, showOn: topVC)
                    }
                    return
                }
            }
        }
    }
    
    
    // api error for custom errors
    enum APIError: Error, CustomStringConvertible {
        
        case url(URLError?)
        case badResponse(statusCode: Int)
        case unknown(Error)
        
        
        static func convert(error: Error) -> APIError {
            switch error {
            case is URLError:
                return .url(error as? URLError)
            case is APIError:
                return error as! APIError
            default:
                return .unknown(error)
            }
        }
        var description: String {
            return ""
        }
    }
}
