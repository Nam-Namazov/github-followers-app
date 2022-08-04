//
//  FollowerListCollectionViewCell.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import UIKit

final class FollowerListCollectionViewCell: UICollectionViewCell {
    static let identifier = "FollowerListCollectionViewCell"
    
    private let avatarImageView = FollowerProfileImage(frame: .zero)
    private let usernameLabel = TitleLabel(textAlignment: .center,
                                                fontSize: 16)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(follower: FollowerModel) {
        usernameLabel.text = follower.login
        NetworkManager.shared.downloadImage(from: follower.avatarUrl) { [weak self] image in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.avatarImageView.image = image
            }
        }
    }
    
    private func setupLayout() {
        // addSubview
        contentView.addSubviews(avatarImageView,
                                usernameLabel)
        
        NSLayoutConstraint.activate([
            // avatarImageView
            avatarImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            avatarImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            avatarImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            // usernameLabel
            usernameLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: 8),
            usernameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            usernameLabel.heightAnchor.constraint(equalToConstant: 20)
        ])
    }
}
