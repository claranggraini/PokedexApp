//
//  PokemonResponse.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 22/11/22.
//

import Foundation

struct SpeciesResponse: Decodable{
    let name: String
    let url: URL?
}

struct SpriteResponse: Decodable{
    let other: Other
}

struct Other: Decodable{
    let officialArtwork: OfficialArtworkResponse
    enum CodingKeys: String, CodingKey{
        case officialArtwork = "official-artwork"
        
    }
}

struct OfficialArtworkResponse: Decodable{
    let frontDefault: URL?
    enum CodingKeys: String, CodingKey{
        case frontDefault = "front_default"
    }
}

struct StatCategory: Decodable{
    let baseStat: Int
    let stat: StatResponse
    enum CodingKeys: String, CodingKey{
        case baseStat = "base_stat"
        case stat
    }
}

struct StatResponse: Decodable{
    let name: String
}

struct TypeCategoryResponse: Decodable{
    let type: PokemonTypeResponse
}

struct PokemonTypeResponse: Decodable{
    let name: String
}

struct MoveCategoryResponse: Decodable{
    let move: MoveResponse
    var versionDetails: [MoveVersionDetailResponse]
    
    enum CodingKeys: String, CodingKey{
        case versionDetails = "version_group_details"
        case move
    }
}

struct MoveResponse: Decodable{
    let name: String
}

struct MoveVersionDetailResponse: Decodable{
    let levelLearnedAt: Int
    let moveLearnMethod: MoveLearnedMethodResponse
    
    enum CodingKeys: String, CodingKey{
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
    }
}

struct MoveLearnedMethodResponse: Decodable{
    let name: String
}

struct PokemonResponse: Decodable{
    let id: Int
    let name: String
    let species: SpeciesResponse
    let sprites: SpriteResponse
    let stats: [StatCategory]
    let moves: [MoveCategoryResponse]
    let types: [TypeCategoryResponse]
    let height: Int
    let weight: Int
}

