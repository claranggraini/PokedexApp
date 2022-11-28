//
//  CatchPokemonCoordinator.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 28/11/22.
//

import Foundation
import UIKit

protocol CatchPokemonCoordinatorProtocol: Coordinator {
    func showCatchPokemonViewController()
}

class CatchPokemonCoordinator: CatchPokemonCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .catchPokemon }
        
    var viewModel = CatchPokemonViewModel()
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        showCatchPokemonViewController()
    }
    
    deinit {
        print("CatchPokemonCoordinator deinit")
    }
    
    func showCatchPokemonViewController() {
        let catchPokemonVC: CatchPokemonViewController = .init()
        catchPokemonVC.modalPresentationStyle = .fullScreen
        catchPokemonVC.navigationItem.setHidesBackButton(true, animated: true)
        catchPokemonVC.viewModel = viewModel
        catchPokemonVC.didSendEventClosure = { [weak self] event, pokemon in
            switch event {
            case .didCatchPokemon:
                self?.finish()
            }
        }
        
        navigationController.pushViewController(catchPokemonVC, animated: true)
    }
}
