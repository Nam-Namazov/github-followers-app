//
//  UserInfoViewController.swift
//  githubFollowersApp
//
//  Created by Намик on 8/2/22.
//

import UIKit

final class UserInfoViewController: UIViewController {
    var username: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        configureNavBarButtonItem()
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
    }
    
    private func configureNavBarButtonItem() {
        let doneRightNavBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                        target: self,
                                                        action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneRightNavBarButtonItem
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
}
