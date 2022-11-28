//
//  DetailPokemonCoordinator.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 28/11/22.
//

import Foundation
import UIKit

protocol DetailPokemonCoordinatorProtocol: Coordinator {
    func showDetailPokemonViewController()
}

class DetailPokemonCoordinator: DetailPokemonCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .detailPokemon }
    
    var viewModel = DetailPokemonViewModel()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        showDetailPokemonViewController()
    }
    
    deinit {
        print("DetailPokemonCoordinator deinit")
    }
    
    func showDetailPokemonViewController() {
        let detailVC = DetailPokemonViewController()
        detailVC.viewModel = viewModel
        
        detailVC.didSendEventClosure = { [weak self] event, pokemon in
            switch event{
            case .succeedCaughtPokemon:
                let viewModel = CatchPokemonViewModel()
                viewModel.pokemon.value = pokemon
                let catchPokemonCoordinator = CatchPokemonCoordinator(self?.navigationController ?? UINavigationController())
                catchPokemonCoordinator.finishDelegate = self
                catchPokemonCoordinator.viewModel = viewModel
                
                catchPokemonCoordinator.start()

                self?.childCoordinators.append(catchPokemonCoordinator)
            
            }
        }
        navigationController.pushViewController(detailVC, animated: true)
        
    }
}

extension DetailPokemonCoordinator: CoordinatorFinishDelegate{
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })
        
        switch childCoordinator.type {
        default:
            let catchCoor = childCoordinator as? CatchPokemonCoordinator
            catchCoor?.navigationController.popViewController(animated: true)
        }
    }
}
