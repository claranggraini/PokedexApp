//
//  DetailPokemonViewModel.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 23/11/22.
//

import Foundation

final class DetailPokemonViewModel{
    var pokemon: ObservableObject<Pokemon?> = ObservableObject(nil)

    init() {
        
    }
    
    func fetchPokemonData(pokemon: Pokemon){
        self.pokemon.value = pokemon
    }
    
    func saveCaughtPokemon(pokemon: Pokemon, nickName: String){
        AppDelegate.sharedAppDelegate.coreDataManager.addPokemon(pokemon: pokemon, nickName: nickName)
    }
}
