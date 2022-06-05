//
//  SceneDelegate.swift
//  Hi
//
//  Created by Hassaan Fayyaz Ahmed on 5/30/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {

        window = UIWindow()
        window?.windowScene = scene as? UIWindowScene
        var networkManager: NetworkManagerProtocol = NetworkManager()
        if CommandLine.arguments.contains(UITestingConstants.LaunchArguments.mockHomeNetworkService.rawValue) {
            networkManager = MockNetworkManager()
        }
        let homeViewModel = HomeViewModel(homeNetworkService: HomeNetworkService(networkManager: networkManager))
        let homeVC = HomeViewController.createListViewController(homeViewModel: homeViewModel)
        window?.rootViewController = UINavigationController(rootViewController: homeVC)
        window?.makeKeyAndVisible()
    }

}
