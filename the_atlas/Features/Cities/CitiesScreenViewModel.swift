//
//  CitiesScreenViewModel.swift
//  the_atlas
//
//  Created by Lasen Punyawardana on 2025-11-20.
//

import Foundation
import Observation

@Observable
class CititesScreenViewModel {
    var cities: [String] = []
    var errorMessage: String = ""
    var state: LoadingState = .idle
    var selectedCountry: String = ""
    
    private let service: DefaultNetworkService
    
    init() {
        service = DefaultNetworkService()
    }
    
    func fetchCities() async {
        state = .loading
        
        do {
            let fetchData = try await service.fetchCities(country: selectedCountry)
            
            cities = fetchData.data
            state = .loaded
        } catch {
            errorMessage = "Failed to fetch cities"
            print(error.localizedDescription)
            state = .error
        }
    }
}
