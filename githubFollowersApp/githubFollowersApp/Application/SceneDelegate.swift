//
//  SceneDelegate.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {
    var window: UIWindow?

    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else {
            return
        }
        
        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = MainTabBarController()
        window?.makeKeyAndVisible()
    }
}

