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
    
    static func mapPokemonResponsesToModel(input pokemonResponse: PokemonResponse, pokemonSprite: UIImage, caughtPokemon: [PokemonEntity]) -> Pokemon{
        var pokemonStat = Array<Stat>()
        var pokemonMoves = Array<Move>()
        var pokemonTypes = Array<PokemonType>()
        
        guard let pokemonResponseStats = pokemonResponse.stats else { return Pokemon()}
        
        guard let pokemonResponseMoves = pokemonResponse.moves else { return Pokemon() }
        
        guard let pokemonResponseTypes = pokemonResponse.types else {return Pokemon()}
        
        for pokeStat in pokemonResponseStats{
            pokemonStat.append(Stat(baseStat: pokeStat.baseStat, name: pokeStat.stat?.name))
        }
        
        for pokeType in pokemonResponseTypes{
            pokemonTypes.append(PokemonType(name: pokeType.type?.name))
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
        
        let caught = checkIfPokemonWasCaught(caughtPokemon: caughtPokemon, id: pokemonResponse.id ?? 0)
        
        return Pokemon(id: pokemonResponse.id, name: pokemonResponse.name, sprite: pokemonSprite, stats: pokemonStat, moves: pokemonMoves, types: pokemonTypes,height: pokemonResponse.height, weight: pokemonResponse.weight, wasCaught: caught)
    }
    
    static func checkIfPokemonWasCaught(caughtPokemon: [PokemonEntity], id: Int) -> Bool{
       
        if caughtPokemon.first(where: {
            $0.pokedexID == id
        }) != nil{
            return true
        }
        
        return false
    }
}

extension Int32{
    func convertToInt() -> Int{
        let num32 = self
        return Int(num32)
    }
}
