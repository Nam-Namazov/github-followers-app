//
//  ItemInfoViewController.swift
//  githubFollowersApp
//
//  Created by Намик on 8/2/22.
//

import UIKit

final class ItemInfoViewController: UIViewController {
    private let stackView = UIStackView()
    private let firstItemInfoView = FollowerProfileItemView()
    private let secondItemInfoView = FollowerProfileItemView()
    private let actionButton = ActionButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureBackgroundView()
        setupLayout()
    }
    
    private func configureBackgroundView() {
        view.layer.cornerRadius = 18
        view.backgroundColor = .secondarySystemBackground
    }
    
    private func configureStackView() {
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        
        stackView.addArrangedSubview(firstItemInfoView)
        stackView.addArrangedSubview(secondItemInfoView)
    }
    
    private func setupLayout() {
        view.addSubview(stackView)
        view.addSubview(actionButton)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // stackView
            stackView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            // actionButton
            actionButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20),
            actionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            actionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        ])
        
    }

}
