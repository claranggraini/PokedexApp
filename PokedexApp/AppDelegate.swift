//
//  AppDelegate.swift
//  PokedexApp
//
//  Created by Clara Anggraini on 21/11/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var appCoordinator: AppCoordinator?
    var window: UIWindow?
//    lazy var coreDataStack: CoreDataManager = .init(modelName: "PokemonDB")
//
//    static let sharedAppDelegate: AppDelegate = {
//        guard let delegate = UIApplication.shared.delegate as? AppDelegate else {
//            fatalError("Unexpected app delegate type, did it change? \(String(describing: UIApplication.shared.delegate))")
//        }
//        return delegate
//    }()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
//        window = UIWindow.init(frame: UIScreen.main.bounds)
//        let viewController = PokemonListViewController()
//        
//        let navigationController = UINavigationController(rootViewController: viewController)
//
//        window?.rootViewController = navigationController
//        window?.makeKeyAndVisible()
//
//        appCoordinator = AppCoordinator.init(navigationController)
//        appCoordinator?.start()
                   
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

