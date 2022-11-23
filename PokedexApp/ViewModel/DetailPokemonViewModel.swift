//
//  DetailPokemonViewModel.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 23/11/22.
//

import Foundation

import UIKit

final class DetailPokemonViewModel{
    var pokemon: ObservableObject<Pokemon?> = ObservableObject(nil)
    var errorAlert: ObservableObject<String?> = ObservableObject(nil)
    
    init() {
        
    }
    
    func fetchPokemonData(pokemon: Pokemon){
        self.pokemon.value = pokemon
    }
    
    func saveCaughtPokemon(){
        
    }
}