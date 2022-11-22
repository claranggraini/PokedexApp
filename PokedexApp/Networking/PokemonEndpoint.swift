//
//  PokemonEndpoint.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 22/11/22.
//

import Foundation

enum PokemonEndpoint {
    case getPokemons
}

extension PokemonEndpoint: Endpoint {
    var host: String {
        "pokeapi.co"
    }

    var path: String {
        switch self {
        case .getPokemons:
            return "api/v2/pokemon"
        
        }
    }
    
    var header: [String : String]? {
        switch self{
        case .getPokemons:
            return [
                
                "Content-Type": "application/json;charset=utf-8"
            ]
        }
        
    }

    var method: HTTPMethod {
        switch self {
        case .getPokemons:
            return .get
        }
    }

    var body: [String : Any]? {
        switch self {
        case .getPokemons:
            return ["limit": 100]
        }
    }
}
