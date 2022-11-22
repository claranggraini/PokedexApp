//
//  PokemonResponse.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 22/11/22.
//

import Foundation

struct Species: Decodable{
    let name: String
    let url: URL?
}

struct Sprite: Decodable{
    let other: Other
}

struct Other: Decodable{
    let officialArtwork: OfficialArtwork
    enum CodingKeys: String, CodingKey{
        case officialArtwork = "official-artwork"
        
    }
}

struct OfficialArtwork: Decodable{
    let frontDefault: URL?
    enum CodingKeys: String, CodingKey{
        case frontDefault = "front_default"
    }
}

struct StatCategory: Decodable{
    let baseStat: Int
    let stat: Stat
    enum CodingKeys: String, CodingKey{
        case baseStat = "base_stat"
        case stat
    }
}

struct Stat: Decodable{
    let name: String
}

struct TypeCategory: Decodable{
    let type: PokemonType
}

struct PokemonType: Decodable{
    let name: String
}

struct MoveCategory: Decodable{
    let move: Move
    var versionDetails: [MoveVersionDetail]
    
    enum CodingKeys: String, CodingKey{
        case versionDetails = "version_group_details"
        case move
    }
}

struct Move: Decodable{
    let name: String
}

struct MoveVersionDetail: Decodable{
    let levelLearnedAt: Int
    let moveLearnMethod: MoveLearnedMethod
    
    enum CodingKeys: String, CodingKey{
        case levelLearnedAt = "level_learned_at"
        case moveLearnMethod = "move_learn_method"
    }
}

struct MoveLearnedMethod: Decodable{
    let name: String
}

struct Pokemon: Decodable{
    let id: Int
    let name: String
    let species: Species
    let sprites: Sprite
    let stats: [StatCategory]
    let moves: [MoveCategory]
    let height: Int
    let weight: Int
}

