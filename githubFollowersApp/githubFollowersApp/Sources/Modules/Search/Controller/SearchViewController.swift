//
//  SearchVC.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import UIKit

final class SearchViewController: UIViewController {
    private let logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "gh-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    private let enterUsernameTextField = LoginCustomTextField()
    
    private let getFollowersButton = GetFollowersButton(backGroundColor: .systemGreen, title: "Get Followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setupLayout()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true 
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        title = "Search"
    }
    
    private func setupLayout() {
        view.addSubview(logoImageView)
        view.addSubview(enterUsernameTextField)
        view.addSubview(getFollowersButton)
        
        NSLayoutConstraint.activate([
            // logoImageView
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            // enterUsernameTextField
            enterUsernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            enterUsernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            enterUsernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            enterUsernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // getFollowersButton
            getFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -50),
            getFollowersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            getFollowersButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}
