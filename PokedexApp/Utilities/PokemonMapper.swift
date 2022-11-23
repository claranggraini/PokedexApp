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
        
        return Pokemon(id: pokemonResponse.id, name: pokemonResponse.name, sprite: pokemonSprite, stats: pokemonStat, moves: pokemonMoves, types: pokemonTypes,height: pokemonResponse.height, weight: pokemonResponse.weight)
        
    }
    
    static func mapPokemonCoreEntityToModel(entity: PokemonEntity) -> Pokemon{
        
        guard let decodedData = Data(base64Encoded: entity.sprite ?? "") else {return Pokemon()}
        var pokeType = Array<PokemonType>()
        
        if let pTypes = entity.pokemonType{
            for type in pTypes {
                pokeType.append(PokemonType(name: type))
            }
        }
        
        return Pokemon(id: entity.id.convertToInt(), name: entity.name, sprite: UIImage(data: decodedData), stats: [], moves: [], types: pokeType, height: entity.height.convertToInt(), weight: entity.weight.convertToInt())
    }
    
}

extension Int32{
    func convertToInt() -> Int{
        let num32 = self
        return Int(num32)
    }
}
