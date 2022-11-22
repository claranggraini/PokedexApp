//
//  PokemonEndpoint.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 22/11/22.
//

import Foundation

enum PokemonEndpoint {
    case getPokemons
    case getPokemonDetail(name: String)
}

extension PokemonEndpoint: Endpoint {
    var host: String {
        "pokeapi.co"
    }

    var path: String {
        switch self {
        case .getPokemons:
            return "/api/v2/pokemon"
        case .getPokemonDetail(let name):
            return "/api/v2/pokemon/\(name)"
        }
    }
    
    var header: [String : String]? {
        switch self{
        default:
            return nil
        }
        
    }

    var method: HTTPMethod {
        switch self {
        case .getPokemons:
            return .get
        case .getPokemonDetail:
            return .get
        }
    }

    var body: [String : Any]? {
        switch self {
        default:
            return nil
        }
    }
    
    var query: [URLQueryItem]? {
        switch self{
        case .getPokemons:
            return [URLQueryItem(name: "limit", value: String(100))]
        default:
            return nil
        }
    }
}
