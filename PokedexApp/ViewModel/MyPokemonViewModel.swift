//
//  MyPokemonViewModel.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 23/11/22.
//

import Foundation

final class MyPokemonViewModel{
    var pokemonEntity: ObservableObject<[PokemonEntity]?> = ObservableObject(nil)
    var errorAlert: ObservableObject<String?> = ObservableObject(nil)
    
    init() {
        
    }
    
    func fetchPokemonData(){
        self.pokemonEntity.value = AppDelegate.sharedAppDelegate.coreDataManager.getAllMyPokemonEntity()
    }
    
    func deletePokemonData(toBeDeletedPokemonEntity: PokemonEntity){
        AppDelegate.sharedAppDelegate.coreDataManager.deletePokemon(pokemonEntity: toBeDeletedPokemonEntity)
    }
    
}
