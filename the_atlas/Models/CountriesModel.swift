//
//  CountriesModel.swift
//  the_atlas
//
//  Created by Lasen Punyawardana on 2025-11-20.
//

import Foundation

struct CountriesModel: Decodable {
    let error: Bool
    let msg: String
    let data: [Country]
}

struct Country: Decodable, Identifiable {
    let id = UUID()
    let name: String
    let flag: String
    let isoTwo: String
    let isoThree: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case flag
        case isoTwo = "iso2"
        case isoThree = "iso3"
    }
}
