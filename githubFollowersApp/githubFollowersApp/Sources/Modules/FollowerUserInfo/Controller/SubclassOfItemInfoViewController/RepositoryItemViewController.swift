//
//  RepositoryItemViewController.swift
//  githubFollowersApp
//
//  Created by Намик on 8/2/22.
//

import UIKit

final class RepositoryItemViewController: ItemInfoViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    private func configureItems() {
        firstItemInfoView.set(itemInfoType: .repos,
                              withCount: profile.publicRepos)
        
        secondItemInfoView.set(itemInfoType: .gists,
                               withCount: profile.publicGists)
        
        actionButton.set(backgroundColor: .systemPurple,
                         title: "Github Profile")
        
    }
}
