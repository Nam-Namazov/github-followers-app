//
//  SearchVC.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import UIKit

final class SearchViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
    }
    
    private func style() {
        view.backgroundColor = .systemPink
        title = "Search"
    }
}
