//
//  CountriesScreen.swift
//  the_atlas
//
//  Created by Lasen Punyawardana on 2025-11-20.
//

import SwiftUI

struct CountriesScreen: View {
    @State var viewModel = CountriesScreenViewModel()
    @State private var searchText: String = ""
    
    var filteredCountries: [Country] {
        if searchText.isEmpty {
            return viewModel.countries
        } else {
            return viewModel.countries.filter {
                $0.name.lowercased().contains(searchText.lowercased())
            }
        }
    }
    
    var body: some View {
        VStack {
            switch viewModel.state {
            case .idle:
                Text("This is easier than i thought.")
            case .loading:
                ProgressView()
            case.loaded:
                List(filteredCountries) { country in
                    NavigationLink(destination: CitiesScreen(country: country)) {
                        VStack {
                            Text(country.name)
                                .font(.headline)
                                .foregroundColor(.primary)
                        }
                        .padding(.vertical, 8)
                    }
                }
                .listStyle(PlainListStyle())
            case .error:
                Text(viewModel.errorMessge)
            }
        }
        .navigationTitle("Countries")
        .searchable(text: $searchText, prompt: "Search Contries")
        .task {
            await viewModel.fetchCountries()
        }
    }
}

#Preview {
    CountriesScreen()
}
