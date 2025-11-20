//
//  CitiesScreen.swift
//  the_atlas
//
//  Created by Lasen Punyawardana on 2025-11-20.
//

import SwiftUI

struct CitiesScreen: View {
    @State var viewModel = CititesScreenViewModel()
    @State var searchText: String = ""
    
    let country: Country
    
    var filteredCities: [String] {
        if searchText.isEmpty {
            return viewModel.cities
        } else {
            return viewModel.cities.filter { city in
                city.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                Text("No cities found!")
            case .loading:
                ProgressView()
            case .loaded:
                List(filteredCities, id: \.self) { city in
                    VStack(alignment: .leading) {
                        Text(city)
                            .font(.headline)
                    }
                }
            case .error:
                Text(viewModel.errorMessage)
            }
        }
        .navigationTitle(country.name)
        .searchable(text: $searchText, prompt: "Search Cities")
        .task {
            viewModel.selectedCountry = country.name
            await viewModel.fetchCities()
        }
    }
}
