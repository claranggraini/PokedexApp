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
    private lazy var userDefaults = UserDefaults.standard
    init() {
        
    }
    
    func catchPokemon()->Bool{
        let randomBool = Bool.random()
        self.catchResult.value = randomBool
        return randomBool
    }
    
    func saveCaughtPokemon(pokemon: Pokemon, nickName: String){
        AppDelegate.sharedAppDelegate.coreDataManager.addPokemon(pokemon: pokemon, nickName: nickName)
       
        var caughtPokemonArr = userDefaults.object(forKey: "caughtPokemon") as? [Int] ?? []
        guard !caughtPokemonArr.contains(pokemon.id ?? -1) else {return}
  
        caughtPokemonArr.append(pokemon.id ?? -1)
        userDefaults.set(caughtPokemonArr, forKey: "caughtPokemon")
    }
    
    func checkNicknameMaxChar(nickname: String)->Bool{
        if nickname.count < 0 || nickname.count > 11{
            return true
        }
        return false
    }
}
