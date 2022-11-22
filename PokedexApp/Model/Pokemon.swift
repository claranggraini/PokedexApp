//
//  Pokemon.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 22/11/22.
//

import Foundation
import UIKit

struct PokemonList{
    let name: String
}

struct Pokemon{
    let id: Int?
    let name: String?
    let sprite: UIImage?
    let stats: [Stat]?
    let moves: [Move]?
    let height: Int?
    let weight: Int?
    
    init(id: Int?, name: String?, sprite: UIImage?, stats: [Stat]?, moves: [Move]?, height: Int?, weight: Int?) {
        self.id = id ?? 0
        self.name = name ?? "Pokemon Name"
        self.sprite = sprite ?? UIImage()
        self.stats = stats ?? []
        self.moves = moves ?? []
        self.height = height ?? 0
        self.weight = weight ?? 0
    }
    
    init(){
        self.id = 0
        self.name = "Pokemon Name"
        self.sprite = UIImage()
        self.stats = []
        self.moves = []
        self.height = 0
        self.weight = 0
    }
}

struct Stat{
    let baseStat: Int?
    let name: String?
    
    init(baseStat: Int?, name: String?) {
        self.baseStat = baseStat ?? 0
        self.name = name ?? "Stat Name"
    }
}

struct Move{
    let name: String?
    let levelLearnedAt: Int?
    
    init(name: String?, levelLearnedAt: Int?) {
        self.name = name ?? "Move Name"
        self.levelLearnedAt = levelLearnedAt ?? 0
    }
}
