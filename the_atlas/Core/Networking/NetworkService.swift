//
//  NetworkService.swift
//  the_atlas
//
//  Created by Lasen Punyawardana on 2025-11-20.
//

import Foundation

protocol NetworkService: Sendable {
    func fetchCountries() async throws -> CountriesModel
    
    func fetchCities(country: String) async throws -> CitiesModel
}
