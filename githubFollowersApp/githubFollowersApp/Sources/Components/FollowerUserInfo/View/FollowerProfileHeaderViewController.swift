//
//  FollowerProfileHeaderViewController.swift
//  githubFollowersApp
//
//  Created by Намик on 8/2/22.
//

import UIKit

final class FollowerProfileHeaderViewController: UIViewController {
    private var profile: FollowerProfileModel!
    private let profileImageView = FollowerProfileImage(frame: .zero)
    private let loginLabel = TitleLabel(textAlignment: .left,
                                                          fontSize: 34)
    private let nameLabel = SecondaryTitleLabel(fontSize: 18)
    private let locationImageView = UIImageView()
    private let locationLabel = SecondaryTitleLabel(fontSize: 18)
    private let bioLabel = BodyLabel(textAlignment: .left)
    
    init(profile: FollowerProfileModel) {
        super.init(nibName: nil, bundle: nil)
        self.profile = profile
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addSubviews()
        setupLayout()
        configureUIElements()
    }

    private func configureUIElements() {
        downloadProfileImage()
        loginLabel.text = profile.login
        nameLabel.text = profile.name ?? ""
        locationLabel.text = profile.location ?? "No Location"
        bioLabel.text = profile.bio ?? ""
        bioLabel.numberOfLines = 3
        locationImageView.image = UIImage(systemName: SFSymbols.location)
        locationImageView.tintColor = .secondaryLabel
    }
    
    private func downloadProfileImage() {
        NetworkManager.shared.downloadImage(from: profile.avatarUrl) { [weak self] image in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        }
    }
    
    private func addSubviews() {
        let subviews = [profileImageView,
                        loginLabel,
                        nameLabel,
                        locationImageView,
                        locationLabel,
                        bioLabel]
        for subview in subviews {
            view.addSubview(subview)
        }
    }
    
    private func setupLayout() {
        locationImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            // profileImageView
            profileImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            profileImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            profileImageView.widthAnchor.constraint(equalToConstant: 90),
            profileImageView.heightAnchor.constraint(equalToConstant: 90),
            
            // loginLabel
            loginLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor),
            loginLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            loginLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loginLabel.heightAnchor.constraint(equalToConstant: 38),
            
            // nameLabel
            nameLabel.centerYAnchor.constraint(equalTo: profileImageView.centerYAnchor, constant: 8),
            nameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            nameLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            nameLabel.heightAnchor.constraint(equalToConstant: 20),
            
            // locationImageView
            locationImageView.bottomAnchor.constraint(equalTo: profileImageView.bottomAnchor),
            locationImageView.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 12),
            locationImageView.widthAnchor.constraint(equalToConstant: 20),
            locationImageView.heightAnchor.constraint(equalToConstant: 20),
            
            // locationLabel
            locationLabel.centerYAnchor.constraint(equalTo: locationImageView.centerYAnchor),
            locationLabel.leadingAnchor.constraint(equalTo: locationImageView.trailingAnchor, constant: 5),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            locationLabel.heightAnchor.constraint(equalToConstant: 20),
            
            // bioLabel
            bioLabel.topAnchor.constraint(equalTo: profileImageView.bottomAnchor, constant: 12),
            bioLabel.leadingAnchor.constraint(equalTo: profileImageView.leadingAnchor),
            bioLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            bioLabel.heightAnchor.constraint(equalToConstant: 60)
        ])
    }
}
