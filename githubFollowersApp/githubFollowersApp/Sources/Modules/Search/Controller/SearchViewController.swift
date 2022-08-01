//
//  SearchVC.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import UIKit

final class SearchViewController: UIViewController {
    var isUsernameIsEmpty: Bool {
        return !enterUsernameTextField.text!.isEmpty
    }
    
    private let logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = UIImage(named: "gh-logo")
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    private let enterUsernameTextField = LoginCustomTextField()
    
    private let getFollowersButton = GetFollowersButton(backGroundColor: .systemGreen,
                                                        title: "Get Followers")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setupLayout()
        dismissKeyboardWhenUserTappedAtViewTapGesture()
        setupDelegateToTextField()
        addTargetConfigure()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true 
    }
    
    private func dismissKeyboardWhenUserTappedAtViewTapGesture() {
        let tap = UITapGestureRecognizer(target: self.view,
                                         action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    private func setupDelegateToTextField() {
        enterUsernameTextField.delegate = self
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
    
    // MARK: - Selectors And Targets
    private func addTargetConfigure() {
        getFollowersButton.addTarget(self,
                                     action: #selector(pushToTheFollowerListViewController),
                                     for: .touchUpInside)
    }
    
    @objc private func pushToTheFollowerListViewController() {
        guard isUsernameIsEmpty else {
            print("no username")
            return
        }
        let followerListViewController = FollowerListViewController()
        followerListViewController.username = enterUsernameTextField.text
        followerListViewController.title = enterUsernameTextField.text
        navigationController?.pushViewController(followerListViewController, animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushToTheFollowerListViewController()
        return true 
    }
}
