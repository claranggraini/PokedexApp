//
//  TabBarPage.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 21/11/22.
//
import UIKit

enum TabBarPage {
    case pokedex
    case myPokemon

    init?(index: Int) {
        switch index {
        case 0:
            self = .pokedex
        case 1:
            self = .myPokemon
        default:
            return nil
        }
    }
    
    func pageTitleValue() -> String {
        switch self {
        case .pokedex:
            return "Pokedex"
        case .myPokemon:
            return "My Pokemon"
        }
    }

    func pageOrderNumber() -> Int {
        switch self {
        case .pokedex:
            return 0
        case .myPokemon:
            return 1
        }
    }
    
    func iconImage() -> String{
        switch self{
        case .pokedex:
            return "pokedex-icon"
        case .myPokemon:
            return "myPokemon-icon"
        }
    }
}
