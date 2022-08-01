//
//  FollowerProfileImage.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import UIKit

final class FollowerProfileImage: UIImageView {
    let defaultEmptyProfileImage = UIImage(named: "avatar-placeholder")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func configure() {
        layer.cornerRadius = 10
        clipsToBounds = true
        image = defaultEmptyProfileImage
        translatesAutoresizingMaskIntoConstraints = false
    }
}
