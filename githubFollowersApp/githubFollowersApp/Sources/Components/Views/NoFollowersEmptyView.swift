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
        noFollowersTextLabel.numberOfLines = 3
        noFollowersTextLabel.textColor = .secondaryLabel
        
        addSubview(noFollowersTextLabel)
        let labelCenterYConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? -80 : -110
        let messageLabelCenterYConstraint = noFollowersTextLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor, constant: labelCenterYConstant)
        messageLabelCenterYConstraint.isActive = true
        
        NSLayoutConstraint.activate([
            noFollowersTextLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor,
                                                          constant: 40),
            noFollowersTextLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                           constant: -40),
            noFollowersTextLabel.heightAnchor.constraint(equalToConstant: 200)
        ])
    }
    
    private func configureEmptyStateLogoImageView() {
        emptyStateLogoImageView.image = Images.emptyStateLogo
        
        addSubview(emptyStateLogoImageView)
        emptyStateLogoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let logoBottomConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 80 : 40
        let logoImageViewBottomConstraint =             emptyStateLogoImageView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: logoBottomConstant)
        logoImageViewBottomConstraint.isActive = true
        NSLayoutConstraint.activate([
            emptyStateLogoImageView.widthAnchor.constraint(equalTo: self.widthAnchor,
                                                           multiplier: 1.3),
            emptyStateLogoImageView.heightAnchor.constraint(equalTo: self.widthAnchor,
                                                            multiplier: 1.3),
            emptyStateLogoImageView.trailingAnchor.constraint(equalTo: self.trailingAnchor,
                                                              constant: 170)
        ])
    }
}
