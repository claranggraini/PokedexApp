//
//  PokemonListResponse.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 22/11/22.
//

import Foundation

struct PokemonListResponse: Decodable{
    let results: [PokemonListResult]
}

struct PokemonListResult: Decodable{
    let name: String?
    let url: URL?
}
