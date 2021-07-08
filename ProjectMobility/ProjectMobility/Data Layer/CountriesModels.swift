//
//  CountriesModels.swift
//  ProjectMobility
//
//  Created by Camilo Betancourt on 17/06/21.
//

import Foundation

struct Country: Codable {
    var name: String?
    var capital: String?
    var region: String?
    var latlng: [Double]
}
