//
//  AppCoordinator.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 21/11/22.
//

import UIKit


protocol AppCoordinatorProtocol: Coordinator {
    func showMainFlow()
}

class AppCoordinator: AppCoordinatorProtocol {
    weak var finishDelegate: CoordinatorFinishDelegate? = nil
    
    var navigationController: UINavigationController
    
    var childCoordinators = [Coordinator]()
    
    var type: CoordinatorType { .app }
        
    required init(_ navigationController: UINavigationController) {
        self.navigationController = navigationController
        navigationController.setNavigationBarHidden(true, animated: false)
    }

    func start() {
        showMainFlow()
    }
    
    func showMainFlow() {
        let tabCoordinator = TabCoordinator.init(navigationController)
        tabCoordinator.finishDelegate = self
        tabCoordinator.start()
        childCoordinators.append(tabCoordinator)
    }
}

extension AppCoordinator: CoordinatorFinishDelegate {
    func coordinatorDidFinish(childCoordinator: Coordinator) {
        childCoordinators = childCoordinators.filter({ $0.type != childCoordinator.type })

        switch childCoordinator.type {
        case .tab:
            navigationController.viewControllers.removeAll()
            showMainFlow()
        default:
            break
        }
    }
}
