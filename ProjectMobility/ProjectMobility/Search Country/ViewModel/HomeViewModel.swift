//
//  HomeViewModel.swift
//  ProjectMobility
//
//  Created by Camilo Betancourt on 17/06/21.
//

import Foundation

class HomeViewModel {
    
    var models: [Country] = []
    var filteredModels: [Country] = []
    var didUpdateModels: (() -> Void)?
    let loader = CountryLoader()
    
    func getCountriesInformation() {
        loader.getCountriesFromServer { result in
            switch result {
            case .success(let countries):
                self.models = countries
                self.filteredModels = countries
                self.didUpdateModels?()
            case .failure(let error):
                print("Error \(error)")
            }
        }
    }
    
    func search(using keyword: String) {
        guard !keyword.isEmpty else {
            filteredModels = models
            didUpdateModels?()
            return
        }
        
        filteredModels = models.filter({ $0.name?.lowercased().contains(keyword.lowercased()) ?? false })
        didUpdateModels?()
    }
}
