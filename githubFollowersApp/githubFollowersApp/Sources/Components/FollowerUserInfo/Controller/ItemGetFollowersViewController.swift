//
//  ItemGetFollowersViewController.swift
//  githubFollowersApp
//
//  Created by Намик on 8/2/22.
//

import UIKit

protocol ItemGetFollowersViewControllerDelegate: AnyObject {
    func didTapGetFollowers(for profiel: FollowerProfileModel )
}

final class ItemGetFollowersViewController: ItemInfoViewController {
    weak var delegate: ItemGetFollowersViewControllerDelegate?
    
    init(profile: FollowerProfileModel,
         delegate: ItemGetFollowersViewControllerDelegate) {
        super.init(profile: profile)
        self.delegate = delegate
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
