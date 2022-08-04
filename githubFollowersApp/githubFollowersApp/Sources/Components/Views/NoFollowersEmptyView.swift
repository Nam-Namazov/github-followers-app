//
//  NoFollowersEmptyView.swift
//  githubFollowersApp
//
//  Created by Намик on 8/2/22.
//

import UIKit

final class NoFollowersEmptyView: UIView {
    private let noFollowersTextLabel: TitleLabel = {
        let textLabel = TitleLabel(textAlignment: .center,
                                   fontSize: 28)
        textLabel.numberOfLines = 3
        textLabel.textColor = .secondaryLabel
        return textLabel
    }()
    
    private let emptyStateLogoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = Images.emptyStateLogo
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    convenience init(text: String) {
        self.init(frame: .zero)
        noFollowersTextLabel.text = text
    }
    
    private func setupLayout() {
        configureNoFollowersTextLabel()
        configureEmptyStateLogoImageView()
    }
    
    private func configureNoFollowersTextLabel() {
        addSubview(noFollowersTextLabel)
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -110
        
        NSLayoutConstraint.activate([
            noFollowersTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 40),
            noFollowersTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -40),
            noFollowersTextLabel.heightAnchor.constraint(equalToConstant: 200),
            noFollowersTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant)
        ])
    }
    
    private func configureEmptyStateLogoImageView() {
        addSubview(emptyStateLogoImageView)
        let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40

        NSLayoutConstraint.activate([
            emptyStateLogoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant),
            emptyStateLogoImageView.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            emptyStateLogoImageView.heightAnchor.constraint(equalTo: self.widthAnchor, multiplier: 1.3),
            emptyStateLogoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 170)
        ])
    }
}
