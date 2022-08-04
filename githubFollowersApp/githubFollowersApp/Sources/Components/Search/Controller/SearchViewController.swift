//
//  SearchViewController.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import UIKit

final class SearchViewController: UIViewController {
    var isUsernameIsEmpty: Bool {
        return !enterUsernameTextField.text!.isEmpty
    }
    var logoImageViewConstraint: NSLayoutConstraint!
    
    private let logoImageView: UIImageView = {
        let logoImageView = UIImageView()
        logoImageView.image = Images.ghLogo
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        return logoImageView
    }()
    
    private let enterUsernameTextField = UsernameTextField()
    
    private let getFollowersButton = ActionButton(backGroundColor: .systemGreen,
                                                        title: "Get Followers")
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setupLayout()
        dismissKeyboardWhenUserTappedAtViewTapGesture()
        setupDelegateToTextField()
        addTargetConfigure()
    }
    
    private func dismissKeyboardWhenUserTappedAtViewTapGesture() {
        let tap = UITapGestureRecognizer(target: view,
                                         action: #selector(UIView.endEditing(_:)))
        view.addGestureRecognizer(tap)
    }
    
    private func setupDelegateToTextField() {
        enterUsernameTextField.delegate = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        enterUsernameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        title = "Search"
    }

    private func setupLayout() {
        view.addSubviews(logoImageView,
                         enterUsernameTextField,
                         getFollowersButton)
        
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        logoImageViewConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
        logoImageViewConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            // logoImageView
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            // enterUsernameTextField
            enterUsernameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor,
                                                        constant: 48),
            enterUsernameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                            constant: 50),
            enterUsernameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                             constant: -50),
            enterUsernameTextField.heightAnchor.constraint(equalToConstant: 50),
            
            // getFollowersButton
            getFollowersButton.leadingAnchor.constraint(equalTo: view.leadingAnchor,
                                                        constant: 50),
            getFollowersButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                       constant: -50),
            getFollowersButton.trailingAnchor.constraint(equalTo: view.trailingAnchor,
                                                         constant: -50),
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
            presentAlertOnMainThread(title: "Empty Username",
                                     message: "Please enter a username. We need to know who to look for 😉",
                                     buttonTitle: "Ok")
            return
        }
        enterUsernameTextField.resignFirstResponder()
        
        let followerListViewController = FollowerListViewController(username: enterUsernameTextField.text!)
        
        navigationController?.pushViewController(followerListViewController,
                                                 animated: true)
    }
}

// MARK: - UITextFieldDelegate
extension SearchViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushToTheFollowerListViewController()
        return true 
    }
}
