//
//  FavoritesListVC.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import UIKit

final class FavoritesListViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        
    }
    
    private func style() {
        view.backgroundColor = .systemBlue
        title = "Favorites"
    }
}
