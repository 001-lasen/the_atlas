//
//  CountriesScreenViewModel.swift
//  the_atlas
//
//  Created by Lasen Punyawardana on 2025-11-20.
//

import Foundation
import Observation

@Observable
class CountriesScreenViewModel {
    var countries: [Country] = []
    var errorMessge: String = ""
    var state: LoadingState = .idle
    
    private let service: DefaultNetworkService
    
    init() {
        service = DefaultNetworkService()
    }
    
    func fetchCountries() async {
        state = .loading
        
        do {
            let fetchData = try await service.fetchCountries()
            
            countries = fetchData.data
            state = .loaded
        } catch {
            errorMessge = "Failed to fetch countries"
            print(error.localizedDescription)
            state = .error
        }
    }
}
