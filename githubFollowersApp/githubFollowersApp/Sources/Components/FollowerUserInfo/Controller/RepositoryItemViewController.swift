//
//  RepositoryItemViewController.swift
//  githubFollowersApp
//
//  Created by Намик on 8/2/22.
//

import UIKit

protocol RepositoryItemViewControllerDelegate: AnyObject {
    func didTapGithubProfile(for profile: FollowerProfileModel)
}

final class RepositoryItemViewController: ItemInfoViewController {
    weak var delegate: RepositoryItemViewControllerDelegate?
    
    init(profile: FollowerProfileModel,
         delegate: RepositoryItemViewControllerDelegate) {
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
        delegate?.didTapGithubProfile(for: profile)
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
