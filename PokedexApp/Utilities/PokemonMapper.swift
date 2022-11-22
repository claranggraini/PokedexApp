//
//  PokemonMapper.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 22/11/22.
//

import Foundation

final class PokemonMapper{
   
    static func mapPokemonListResponsesToModel(input pokemonListResponse: PokemonListResponse) -> [PokemonList]{
     
        return pokemonListResponse.results.map{ result in
           
            return PokemonList(name: result.name ?? "")
        }
    }
    
    static func mapPokemonResponsesToModel(input pokemonResponse: PokemonResponse) -> Pokemon{
        var pokemonStat = Array<Stat>()
        var pokemonMoves = Array<Move>()
        
        for pokeStat in pokemonResponse.stats{
            pokemonStat.append(Stat(baseStat: pokeStat.baseStat, name: pokeStat.stat.name))
        }
        
        let filteredPokemonMove = pokemonResponse.moves.filter({
            return $0.versionDetails.contains(where: {
                $0.moveLearnMethod.name == "level-up"
            })
        })
        
        for pokemonMove in filteredPokemonMove {
            
            pokemonMoves.append(Move(name: pokemonMove.move.name, levelLearnedAt: pokemonMove.versionDetails.first?.levelLearnedAt))
        }
        
        return Pokemon(id: pokemonResponse.id, name: pokemonResponse.name, sprite: pokemonResponse.sprites.other.officialArtwork.frontDefault?.absoluteString, stats: pokemonStat, moves: pokemonMoves, height: pokemonResponse.height, weight: pokemonResponse.weight)
        
    }
}
