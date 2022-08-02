//
//  CustomAlertViewController.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import UIKit

final class CustomAlertViewController: UIViewController {
    private let containerView: UIView = {
        let containerView = UIView()
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
        containerView.layer.borderColor = UIColor.white.cgColor
        containerView.backgroundColor = .systemBackground
        containerView.translatesAutoresizingMaskIntoConstraints = false
        return containerView
    }()
    
    private let errorMessageBodyLabel = BodyLabel(textAlignment: .center)
    private let errorTitleLabel = TitleLabel(textAlignment: .center,
                                                          fontSize: 20)
    private let actionOkayButton = ActionButton(backGroundColor: .systemPink,
                                          title: "Ok")
    private var alertTitle: String?
    private var message: String?
    private var buttonTitle: String?

    init(title: String,
         message: String,
         buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        self.alertTitle = title
        self.message = message
        self.buttonTitle = buttonTitle
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        setupLayoutAndConfigureUI()
        configureUI()
        addTargetConfigure()
    }
    
    private func style() {
        view.backgroundColor = UIColor(red: 0,
                                       green: 0,
                                       blue: 0,
                                       alpha: 0.75)
    }
    
    private func configureUI() {
        errorTitleLabel.text = alertTitle ?? ""
        actionOkayButton.setTitle(buttonTitle ?? "Ok", for: .normal)
        errorMessageBodyLabel.text = message ?? "Unable to complete request"
        errorMessageBodyLabel.numberOfLines = 4
    }
    
    private func setupLayoutAndConfigureUI() {
        view.addSubview(containerView)
        containerView.addSubview(errorTitleLabel)
        containerView.addSubview(actionOkayButton)
        containerView.addSubview(errorMessageBodyLabel)
        
        NSLayoutConstraint.activate([
            // containerView
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220),
            
            // errorTitleLabel
            errorTitleLabel.topAnchor.constraint(equalTo: containerView.topAnchor,
                                                 constant: 20),
            errorTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                     constant: 20),
            errorTitleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                      constant: -20),
            errorTitleLabel.heightAnchor.constraint(equalToConstant: 28),
            
            // actionOkayButton
            actionOkayButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor,
                                                     constant: -20),
            actionOkayButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                      constant: 20),
            actionOkayButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                       constant: -20),
            actionOkayButton.heightAnchor.constraint(equalToConstant: 44),
            
            // errorMessageBodyLabel
            errorMessageBodyLabel.topAnchor.constraint(equalTo: errorTitleLabel.bottomAnchor,
                                                       constant: 8),
            errorMessageBodyLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,
                                                           constant: 20),
            errorMessageBodyLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor,
                                                            constant: -20),
            errorMessageBodyLabel.bottomAnchor.constraint(equalTo: actionOkayButton.topAnchor,
                                                          constant: -12)
        ])
    }
    
    // MARK: - Selectors And Targets
    private func addTargetConfigure() {
        actionOkayButton.addTarget(self,
                                   action: #selector(dismissAlertOkayButtonTapped),
                                   for: .touchUpInside)
    }
    
    @objc private func dismissAlertOkayButtonTapped() {
        dismiss(animated: true)
    }
}
