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
        getData()
        style()
        configureNavBarButtonItem()
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
    }
    
    private func getData() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let user):
                print(user)
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong",
                                              message: error.rawValue,
                                              buttonTitle: "Ok")
            }
        }
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
