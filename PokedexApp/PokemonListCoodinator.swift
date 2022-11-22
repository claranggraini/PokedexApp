////
////  PokemonListCoodinator.swift
////  PokedexApp
////
////  Created by Clara Anggraini on 21/11/22.
////
//
//import Foundation
//import UIKit
//
//protocol PokemonListCoordinatorProtocol: Coordinator {
//    func showPokemonListViewController()
//}
//
//class PokemonListCoordinator: PokemonListCoordinatorProtocol {
//    weak var finishDelegate: CoordinatorFinishDelegate?
//    
//    var navigationController: UINavigationController
//    
//    var childCoordinators: [Coordinator] = []
//    
//    var type: CoordinatorType { .tab }
//        
//    required init(_ navigationController: UINavigationController) {
//        self.navigationController = navigationController
//    }
//        
//    func start() {
//        showPokemonListViewController()
//    }
//    
//    deinit {
//        print("PokemonListCoordinator deinit")
//    }
//    
//    func showPokemonListViewController() {
//        let pokemonListVC: PokemonListViewController = .init()
//        pokemonListVC.navigationController?.title = "Discover"
////        pokemonListVC.didSendEventClosure = { [weak self] event in
////            print("show pokemon list")
////            switch event{
////            case .detail:
////                print("tap detail btn")
////                navigationController.pushViewController(DetailPokemonViewController(), animated: true)
////            }
////        }
//        
//        navigationController.pushViewController(pokemonListVC, animated: true)
//    }
//}
