//
//  PokemonMapper.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 22/11/22.
//

import Foundation
import UIKit

final class PokemonMapper{
   
    static func mapPokemonListResponsesToModel(input pokemonListResponse: PokemonListResponse) -> [PokemonList]{
     
        return pokemonListResponse.results.map{ result in
           
            return PokemonList(name: result.name ?? "")
        }
    }
    
    static func mapPokemonResponsesToModel(input pokemonResponse: PokemonResponse, pokemonSprite: UIImage) -> Pokemon{
        var pokemonStat = Array<Stat>()
        var pokemonMoves = Array<Move>()
        
        guard let pokemonResponseStats = pokemonResponse.stats else { return Pokemon()}
        
        guard let pokemonResponseMoves = pokemonResponse.moves else { return Pokemon() }
        
        for pokeStat in pokemonResponseStats{
            pokemonStat.append(Stat(baseStat: pokeStat.baseStat, name: pokeStat.stat?.name))
        }
        
        let filteredPokemonMove = pokemonResponseMoves.filter({
            guard let versionDetail = $0.versionDetails else {return true}
            return versionDetail.contains(where: {
                $0.moveLearnMethod?.name == "level-up"
            })
        })
        
        for pokemonMove in filteredPokemonMove {
            
            pokemonMoves.append(Move(name: pokemonMove.move?.name, levelLearnedAt: pokemonMove.versionDetails?.first?.levelLearnedAt))
        }
        
        return Pokemon(id: pokemonResponse.id, name: pokemonResponse.name, sprite: pokemonSprite, stats: pokemonStat, moves: pokemonMoves, height: pokemonResponse.height, weight: pokemonResponse.weight)
        
    }
}
