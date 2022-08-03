//
//  FavoritesTableViewCell.swift
//  githubFollowersApp
//
//  Created by Намик on 8/3/22.
//

import UIKit

final class FavoritesTableViewCell: UITableViewCell {
    static let identifier = "FavoritesTableViewCell"
    
    private let profileImageView = FollowerProfileImage(frame: .zero)
    private let usernameLabel = TitleLabel(textAlignment: .left,
                                           fontSize: 26)
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func set(favorite: FollowerModel) {
        usernameLabel.text = favorite.login
        NetworkManager.shared.downloadImage(from: favorite.avatarUrl) { [weak self] image in
            guard let self = self else {
                return
            }
            DispatchQueue.main.async {
                self.profileImageView.image = image
            }
        }
    }
    
    private func configureUI() {
        accessoryType = .disclosureIndicator
    }
    
    private func setupLayout() {
        contentView.addSubview(profileImageView)
        contentView.addSubview(usernameLabel)
        
        NSLayoutConstraint.activate([
            // profileImageView
            profileImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            profileImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 12),
            profileImageView.heightAnchor.constraint(equalToConstant: 60),
            profileImageView.widthAnchor.constraint(equalToConstant: 60),
            
            // usernameLabel
            usernameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            usernameLabel.leadingAnchor.constraint(equalTo: profileImageView.trailingAnchor, constant: 24),
            usernameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -12),
            usernameLabel.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
}
