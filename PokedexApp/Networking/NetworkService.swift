//
//  NetworkService.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 22/11/22.
//
import Foundation

enum HTTPMethod: String {
    case get = "GET"
}

protocol NetworkServicing {
    func request<T: Decodable, E: Endpoint>(to endpoint: E, decodeTo model: T.Type) async -> Result<T, URLError>
}

class NetworkService: NetworkServicing {
    func request<T: Decodable, E: Endpoint>(to endpoint: E, decodeTo model: T.Type) async -> Result<T, URLError> {
        guard let urlRequest = endpoint.urlRequest else {
            return .failure(.invalidResponse)
        }
        
        #if DEBUG
        NetworkLogger.log(request: urlRequest)
        #endif

        do {
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            guard let response = response as? HTTPURLResponse else {
                return .failure(.invalidResponse)
            }

            #if DEBUG
            NetworkLogger.log(data: data, response: response)
            #endif
            
            guard response.statusCode != 404 else {
                print("response failed: \(response.statusCode)")
                return .failure(.invalidResponse)
            }
            
            guard let decodedData = try? JSONDecoder().decode(model, from: data) else {
                print("Fialed decode")
                return .failure(.decoding)
            }
            
            return .success(decodedData)
            
        } catch {
            return .failure(.underlying(error))
        }
    }
}
