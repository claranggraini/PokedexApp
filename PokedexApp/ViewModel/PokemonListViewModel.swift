//
//  PokemonListViewModel.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 22/11/22.
//

import Foundation
import UIKit

final class PokemonListViewViewModel{
    var pokemons: ObservableObject<[Pokemon]?> = ObservableObject(nil)
    private var pokemonList: [PokemonList] = []
    private var pokemonDetailList: [Pokemon] = []
    var isLoading: ObservableObject<Bool?> = ObservableObject(nil)
    var errorAlert: ObservableObject<String?> = ObservableObject(nil)
    
    private let networkService: NetworkServicing
    
    init(networkService: NetworkServicing = NetworkService()) {
        self.networkService = networkService
    }
    
    func fetchPokemonListData() async{
        errorAlert.value = nil
        isLoading.value = true
        
        let endpoint = PokemonEndpoint.getPokemons
        
        let pokemonListResult = await networkService.request(to: endpoint, decodeTo: PokemonListResponse.self)
        
        switch pokemonListResult {
        case .success(let response):
            pokemonList = PokemonMapper.mapPokemonListResponsesToModel(input: response)
           
        case .failure(let error):
            errorAlert.value = error.localizedDescription
            isLoading.value = false
        }
    }
   
    func fetchPokemonDetailData() async{
        
        for pr in pokemonList{
            let result = await networkService.request(to: PokemonEndpoint.getPokemonDetail(name: pr.name), decodeTo: PokemonResponse.self)
            
            switch result {
            case .success(let response):
                let pokemonSprite = await fetchPokemonSprite(url: response.sprites?.other?.officialArtwork?.frontDefault?.absoluteString ?? "")
                pokemonDetailList.append(PokemonMapper.mapPokemonResponsesToModel(input: response, pokemonSprite: pokemonSprite))
                
            case .failure(let error):
                errorAlert.value = error.localizedDescription
                isLoading.value = false
            }
        }
        pokemons.value = pokemonDetailList
        isLoading.value = false
        
    }
    
    func fetchPokemonSprite(url: String) async -> UIImage{
        let pokemonSprite = await networkService.requestImage(url: url)
        switch pokemonSprite{
        case .success(let response):
            return response
        case .failure(let error):
            errorAlert.value = error.localizedDescription
        }
        return UIImage()
    }
}
