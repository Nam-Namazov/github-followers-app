//
//  MainTabBarController.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import UIKit

final class MainTabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        configureVC()
        style()
    }
    
    private func configureVC() {
        let searchViewController = createNavController(viewController: SearchViewController(),
                                                       tabBarSystemItem: .search, tag: 0)
        let favoritesViewController = createNavController(viewController: FavoritesListViewController(),
                                                          tabBarSystemItem: .favorites, tag: 1)
        viewControllers = [searchViewController, favoritesViewController]
    }

    private func createNavController(viewController: UIViewController,
                                     tabBarSystemItem: UITabBarItem.SystemItem,
                                     tag: Int ) -> UINavigationController {
        let navController = UINavigationController(rootViewController: viewController)
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: tabBarSystemItem,
                                                 tag: tag)
        return navController
    }

    private func style() {
        view.backgroundColor = .systemBackground
        tabBar.backgroundColor = .systemBackground
        tabBar.tintColor = .systemGreen
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
        UINavigationBar.appearance().barTintColor = .systemBackground
//        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
//        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
//        UINavigationBar.appearance().shadowImage = UIImage()
//        UINavigationBar.appearance().isTranslucent = true
//        UINavigationBar.appearance().prefersLargeTitles = false
        UINavigationBar.appearance().tintColor = .systemGreen
//        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBarAppearance()
    }
}
