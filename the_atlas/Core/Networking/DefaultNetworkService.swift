//
//  DefaultNetworkService.swift
//  the_atlas
//
//  Created by Lasen Punyawardana on 2025-11-20.
//

import Foundation

struct DefaultNetworkService: NetworkService {
    
    func fetchCountries() async throws -> CountriesModel {
        let url = "https://countriesnow.space/api/v0.1/countries/flag/images"
        
        return try await fetch(url: url, type: CountriesModel.self)
    }
    
    func fetchCities(country: String) async throws -> CitiesModel {
        let url = "https://countriesnow.space/api/v0.1/countries/cities"
        
        let body = CitiesRequestModel(country: country)
        
        return try await post(url: url, body: body, type: CitiesModel.self)
    }
    
    func fetch<T: Decodable>(url: String, type: T.Type) async throws -> T {
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
    
    func post<T: Decodable>(url: String, body: CitiesRequestModel, type: T.Type) async throws -> T {
        guard let url = URL(string: url) else {
            throw APIError.invalidURL
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try JSONEncoder().encode(body)
        
        do {
            let (data, response) = try await URLSession.shared.data(for: request)
            
            guard let httpResponse = response as? HTTPURLResponse, (200..<300).contains(httpResponse.statusCode) else {
                throw APIError.invalidResponse
            }
            
            return try JSONDecoder().decode(T.self, from: data)
        } catch let error as DecodingError {
            throw APIError.decodingError(error)
        } catch let error as URLError {
            throw APIError.networkError(error)
        }
    }
}
