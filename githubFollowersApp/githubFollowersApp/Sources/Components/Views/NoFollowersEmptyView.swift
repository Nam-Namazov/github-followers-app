//
//  NoFollowersEmptyView.swift
//  githubFollowersApp
//
//  Created by Намик on 8/2/22.
//

import UIKit

final class NoFollowersEmptyView: UIView {
    private let noFollowersTextLabel = TitleLabel(textAlignment: .center,
                                                               fontSize: 28)
    private let emptyStateLogoImageView = UIImageView()
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init(frame: .zero)
        noFollowersTextLabel.text = text
    }
    
    private func configureUI() {
        noFollowersTextLabel.numberOfLines = 3
        noFollowersTextLabel.textColor = .secondaryLabel
        
        emptyStateLogoImageView.image = UIImage(named: "empty-state-logo")
    }
    
    private func setupLayout() {
        // addSubview
        addSubview(noFollowersTextLabel)
        addSubview(emptyStateLogoImageView)
        
        emptyStateLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            // noFollowersTextLabel
            noFollowersTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor,
                                                          constant: -150),
            noFollowersTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                          constant: 40),
            noFollowersTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                           constant: -40),
            noFollowersTextLabel.heightAnchor.constraint(equalToConstant: 200),
            
            // emptyStateLogoImageView
            emptyStateLogoImageView.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                           multiplier: 1.3),
            emptyStateLogoImageView.heightAnchor.constraint(equalTo: self.widthAnchor,
                                                            multiplier: 1.3),
            emptyStateLogoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                              constant: 170),
            emptyStateLogoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor,
                                                            constant: 40)
        ])
    }
}
