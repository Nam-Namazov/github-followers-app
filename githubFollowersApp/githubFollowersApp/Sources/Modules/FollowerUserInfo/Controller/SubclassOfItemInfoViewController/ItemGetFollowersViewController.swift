//
//  ItemGetFollowersViewController.swift
//  githubFollowersApp
//
//  Created by Намик on 8/2/22.
//

import UIKit

final class ItemGetFollowersViewController: ItemInfoViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureItems()
    }
    
    override func actionButtonTapped() {
        delegate?.didTapGetFollowers(for: profile)
    }
    
    private func configureItems() {
        firstItemInfoView.set(itemInfoType: .followers,
                              withCount: profile.followers)
        
        secondItemInfoView.set(itemInfoType: .following,
                               withCount: profile.following)
        
        actionButton.set(backgroundColor: .systemGreen,
                         title: "Get Followers")
    }
}
