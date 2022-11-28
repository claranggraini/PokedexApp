//
//  MyPokemonCoordinator.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 28/11/22.
//

import Foundation
import UIKit

protocol MyPokemonCoordinatorProtocol: Coordinator {
    func showMyPokemonViewController()
}

class MyPokemonCoordinator: MyPokemonCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    var navigationController: UINavigationController
    
    var childCoordinators: [Coordinator] = []
    
    var type: CoordinatorType { .myPokemonCoor }
        
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
        
    func start() {
        showMyPokemonViewController()
    }
    
    deinit {
        print("MyPokemonCoordinator deinit")
    }
    
    func showMyPokemonViewController() {
        let myPokemonVC: MyPokemonViewController = MyPokemonViewController()
        navigationController.pushViewController(myPokemonVC, animated: true)
    }
}
