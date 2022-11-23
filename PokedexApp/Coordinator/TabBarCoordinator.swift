//
//  TabBarCoordinator.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 21/11/22.
//

import UIKit

protocol TabCoordinatorProtocol: Coordinator {
    var tabBarController: UITabBarController { get set }
    
    func selectPage(_ page: TabBarPage)
    
    func setSelectedIndex(_ index: Int)
    
    func currentPage() -> TabBarPage?
}

class TabCoordinator: NSObject, Coordinator {
    weak var finishDelegate: CoordinatorFinishDelegate?
        
    var childCoordinators: [Coordinator] = []

    var navigationController: UINavigationController
    
    var tabBarController: UITabBarController

    var type: CoordinatorType { .tab }
    
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        self.tabBarController = .init()
    }

    func start() {
        
        let pages: [TabBarPage] = [.pokedex, .myPokemon]
            .sorted(by: { $0.pageOrderNumber() < $1.pageOrderNumber() })
        
        let controllers: [UINavigationController] = pages.map({ getTabController($0) })
        
        prepareTabBarController(withTabControllers: controllers)
    }
    
    deinit {
        print("TabCoordinator deinit")
    }
    
    private func prepareTabBarController(withTabControllers tabControllers: [UIViewController]) {
        
        tabBarController.delegate = self
        
        tabBarController.setViewControllers(tabControllers, animated: true)
        
        tabBarController.selectedIndex = TabBarPage.pokedex.pageOrderNumber()
       
        tabBarController.tabBar.isTranslucent = false
        
        tabBarController.tabBar.backgroundColor = .systemYellow
        
        navigationController.viewControllers = [tabBarController]
    }
      
    private func getTabController(_ page: TabBarPage) -> UINavigationController {
        let navController = UINavigationController()
        navController.tabBarItem = UITabBarItem.init(title: page.pageTitleValue(),
                                                     image: nil,
                                                     tag: page.pageOrderNumber())

        switch page {
        case .pokedex:
            
            let pokemonListVC = PokemonListViewController()
            
            pokemonListVC.didSendEventClosure = { [weak self] event, pokemon in
                switch event {
                case .detail:
                    let detailVC = DetailPokemonViewController()
                    detailVC.viewModel.fetchPokemonData(pokemon: pokemon)
                    self?.navigationController.pushViewController(detailVC, animated: true)
                }
            }
            
            navController.pushViewController(pokemonListVC, animated: true)
        case .myPokemon:
            let myPokemonVC = MyPokemonViewController()
            navController.pushViewController(myPokemonVC, animated: true)
            
        }
        
        return navController
    }
    
    func currentPage() -> TabBarPage? { TabBarPage.init(index: tabBarController.selectedIndex) }

    func selectPage(_ page: TabBarPage) {
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
    
    func setSelectedIndex(_ index: Int) {
        guard let page = TabBarPage.init(index: index) else { return }
        
        tabBarController.selectedIndex = page.pageOrderNumber()
    }
}


extension TabCoordinator: UITabBarControllerDelegate {
    
}
