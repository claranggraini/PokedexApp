//
//  PokemonListCoordinator.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 28/11/22.
//

import Foundation
import UIKit

protocol PokemonListCoordinatorProtocol: Coordinator {
    func showPokemonListViewController()
}

class PokemonListCoordinator: PokemonListCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .pokemonList }
    
    required init(_ navigationController: UINavigationController) {
        print("navigationController")
        self.navigationController = navigationController
    }
        
    func start() {
        showPokemonListViewController()
    }
    
    deinit {
        print("PokemonListCoordinator deinit")
    }
    
    func showPokemonListViewController() {
        let pokemonListVC = PokemonListViewController()
        pokemonListVC.didSendEventClosure = { [weak self] event, pokemon in
            switch event {
                case .detail:
                let detailCoordinator = DetailPokemonCoordinator.init(self?.navigationController ?? UINavigationController())
                
                    detailCoordinator.viewModel.pokemon.value = pokemon
                    
                    detailCoordinator.start()
                    
                    self?.childCoordinators.append(detailCoordinator)
                    
                }
        }
        navigationController.pushViewController(pokemonListVC, animated: true)

    }
}
