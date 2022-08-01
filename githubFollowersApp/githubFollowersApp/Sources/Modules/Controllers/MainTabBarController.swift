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
        viewController.tabBarItem = UITabBarItem(tabBarSystemItem: tabBarSystemItem, tag: tag)
        return navController
    }

    private func style() {
        view.backgroundColor = .systemGray6
        tabBar.backgroundColor = .white
        tabBar.tintColor = .black
        tabBar.scrollEdgeAppearance = tabBar.standardAppearance
        
        UINavigationBar.appearance().barTintColor = .black
        UINavigationBar.appearance().titleTextAttributes = [.foregroundColor: UIColor.black]
        UINavigationBar.appearance().setBackgroundImage(UIImage(), for: .default)
        UINavigationBar.appearance().shadowImage = UIImage()
        UINavigationBar.appearance().isTranslucent = true
        UINavigationBar.appearance().prefersLargeTitles = false
        UINavigationBar.appearance().tintColor = .black
        UINavigationBar.appearance().scrollEdgeAppearance = UINavigationBarAppearance()
    }
}
