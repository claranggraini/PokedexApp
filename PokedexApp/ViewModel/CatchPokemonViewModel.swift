//
//  CatchPokemonViewModel.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 24/11/22.
//

import Foundation

final class CatchPokemonViewModel{
    var pokemon: ObservableObject<Pokemon?> = ObservableObject(nil)
    var catchResult: ObservableObject<Bool?> = ObservableObject(nil)
    
    init() {
        
    }
    
    func catchPokemon()->Bool{
        let randomBool = Bool.random()
        self.catchResult.value = randomBool
        return randomBool
    }
    
    func saveCaughtPokemon(pokemon: Pokemon, nickName: String){
        AppDelegate.sharedAppDelegate.coreDataManager.addPokemon(pokemon: pokemon, nickName: nickName)
    }
    
    func checkNicknameMaxChar(nickname: String)->Bool{
        if nickname.count < 0 || nickname.count > 11{
            return true
        }
        return false
    }
}
