//
//  CountryLoader.swift
//  ProjectMobility
//
//  Created by Camilo Betancourt on 17/06/21.
//

import Foundation
import Alamofire

enum HTTPClientError: Error {
    case serviceError
    case errorParser
}

protocol CountryLoaderProtocol {
    func getCountriesFromServer(completion: @escaping (Result<[Country], HTTPClientError>) -> Void)
}

class CountryLoader: CountryLoaderProtocol {
    
    let headers = [
        "x-rapidapi-key": "97c89c5cb5mshc73d0c89c3c72d8p12b0d4jsn0aac3b88c286",
        "x-rapidapi-host": "restcountries-v1.p.rapidapi.com"
    ]
    
    let allCountriesURL = "https://restcountries-v1.p.rapidapi.com/all"
    
    func getCountriesFromServer(completion: @escaping (Result<[Country], HTTPClientError>) -> Void) {
        
        AF.request(allCountriesURL,
                   method: .get,
                   headers: HTTPHeaders(headers)).responseJSON { response in
            guard let itemsData = response.data else {
                completion(.failure(.errorParser))
                return
            }
            do {
                let decoder = JSONDecoder()
                let items = try decoder.decode([Country].self, from: itemsData)
                completion(.success(items))
            } catch {
                print()
                completion(.failure(.errorParser))
            }
        }
    }
}

