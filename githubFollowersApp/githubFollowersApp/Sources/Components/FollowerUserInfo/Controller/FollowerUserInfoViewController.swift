//
//  FollowerUserInfoViewController.swift
//  githubFollowersApp
//
//  Created by Намик on 8/2/22.
//

import UIKit

protocol FollowerUserInfoViewControllerDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

final class FollowerUserInfoViewController: UIViewController {
    var username: String!
    private let headerView = UIView()
    private let firstItemView = UIView()
    private let secondItemView = UIView()
    private let githubSinceDateLabel = BodyLabel(textAlignment: .center)
    private let scrollView = UIScrollView()
    private let contentView = UIView()
    weak var delegate: FollowerUserInfoViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getData()
        setupLayout()
        style()
        configureNavBarButtonItem()
        scrollViewAndContentViewLayout()
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
    }
    
    private func getData() {
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let profile):
                DispatchQueue.main.async {
                    self.configureUIElements(with: profile)
                }
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong",
                                              message: error.rawValue,
                                              buttonTitle: "Ok")
            }
        }
    }
    
    private func configureUIElements(with profile: FollowerProfileModel) {
        self.add(childViewController: RepositoryItemViewController(profile: profile, delegate: self),
                 to: self.firstItemView)

        self.add(childViewController: ItemGetFollowersViewController(profile: profile, delegate: self),
                 to: self.secondItemView)
        
        self.add(childViewController: FollowerProfileHeaderViewController(profile: profile),
                 to: self.headerView)
        self.githubSinceDateLabel.text = "〠 Github since \(profile.createdAt.convertToMonthYearFormat())"
    }
    
    private func scrollViewAndContentViewLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        scrollView.pinToEdges(of: view)
        contentView.pinToEdges(of: scrollView)
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
    }
    
    private func setupLayout() {
        let subviews = [headerView,
                        firstItemView,
                        secondItemView,
                        githubSinceDateLabel]
        
        for subview in subviews {
            contentView.addSubview(subview)
            subview.translatesAutoresizingMaskIntoConstraints = false
            
            NSLayoutConstraint.activate([
                subview.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,
                                                 constant: 20),
                subview.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,
                                                  constant: -20)
            ])
        }

        NSLayoutConstraint.activate([
            // headerView
            headerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            headerView.heightAnchor.constraint(equalToConstant: 180),
           
            // firstItemView
            firstItemView.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 20),
            firstItemView.heightAnchor.constraint(equalToConstant: 140),
            
            // secondItemView
            secondItemView.topAnchor.constraint(equalTo: firstItemView.bottomAnchor, constant: 20),
            secondItemView.heightAnchor.constraint(equalToConstant: 140),
            
            //githubSinceDateLabel
            githubSinceDateLabel.topAnchor.constraint(equalTo: secondItemView.bottomAnchor, constant: 20),
            githubSinceDateLabel.heightAnchor.constraint(equalToConstant: 50),
            githubSinceDateLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    private func add(childViewController: UIViewController,
                     to containerView: UIView) {
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.view.frame = containerView.bounds
        childViewController.didMove(toParent: self)
    }
    
    // MARK: - Selectors and Targets
    private func configureNavBarButtonItem() {
        let doneRightNavBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                        target: self,
                                                        action: #selector(dismissViewController))
        navigationItem.rightBarButtonItem = doneRightNavBarButtonItem
    }
    
    @objc private func dismissViewController() {
        dismiss(animated: true)
    }
}

// MARK: - RepositoryItemViewControllerDelegate
extension FollowerUserInfoViewController: RepositoryItemViewControllerDelegate {
    func didTapGithubProfile(for profile: FollowerProfileModel) {
        guard let url = URL(string: profile.htmlUrl) else {
            presentAlertOnMainThread(title: "Invalud URL",
                                     message: "The url attached to this user is invalid",
                                     buttonTitle: "Ok")
            return
        }
        presentSafariViewController(with: url)
    }
}

// MARK: - ItemGetFollowersViewControllerDelegate
extension FollowerUserInfoViewController: ItemGetFollowersViewControllerDelegate {
    func didTapGetFollowers(for profile: FollowerProfileModel) {
        guard profile.followers != 0 else {
            presentAlertOnMainThread(title: "No followers",
                                     message: "This user has no followers 😢",
                                     buttonTitle: "So sad")
            return
        }
        delegate?.didRequestFollowers(for: profile.login)
        dismissViewController()
    }
}
