//
//  FollowerListViewController.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import UIKit

final class FollowerListViewController: DataLoadingViewController {
    enum Section {
        case main
    }
    
    var username: String!
    private var followers: [FollowerModel] = []
    private var page = 1
    private var hasMoreFollowers = true
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section,
                                                               FollowerModel>!
    private var filteredFollowers: [FollowerModel] = []
    private var isSearching = false
    private var isLoadingMoreFollowers = false
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        self.username = username
        title = username
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        configureCollectionView()
        configureSearchController()
        getFollowers(username: username, page: page)
        configureDataSource()
        configureRightNavBarItemButton()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        collectionView = UICollectionView(frame: view.bounds,
                                          collectionViewLayout: UIHelper.createThreeColumnFlowLayout(in: view))
        view.addSubview(collectionView)
        collectionView.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.register(FollowerListCollectionViewCell.self,
                                forCellWithReuseIdentifier: FollowerListCollectionViewCell.identifier)
    }
    
    private func configureSearchController() {
        let searchController = UISearchController()
        navigationItem.searchController = searchController
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        isLoadingMoreFollowers = true
        NetworkManager.shared.getFollowers(for: username,
                                           page: page) { [weak self] result in
            guard let self = self else {
                return
            }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)
                
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Bad Stuff Happened",
                                              message: error.rawValue,
                                              buttonTitle: "Ok")
            }
            self.isLoadingMoreFollowers = false
        }
    }
    
    private func updateUI(with followersToUpdate: [FollowerModel]) {
        if followersToUpdate.count < 100 {
            self.hasMoreFollowers = false
        }
        self.followers.append(contentsOf: followersToUpdate)
        
        if self.followers.isEmpty {
            let text = "This user doesn't have any followers. Go follow them 😇"
            
            DispatchQueue.main.async {
                self.navigationItem.searchController?.searchBar.isHidden = true
                self.showEmptyStateView(with: text, in: self.view)
            }
            return
        }
        self.updateData(on: self.followers)
    }
    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, FollowerModel>(collectionView: collectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerListCollectionViewCell.identifier, for: indexPath) as? FollowerListCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(follower: follower)
            return cell
        })
    }
    
    private func updateData(on followers: [FollowerModel]) {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FollowerModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot,
                                  animatingDifferences: true)
        }
    }
    
    // MARK: - Selectors and Targets
    private func configureRightNavBarItemButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(handleAddTapButton))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func handleAddTapButton() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else {
                return
            }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                self.addUserToFavorites(user: user)
                
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong",
                                              message: error.rawValue,
                                              buttonTitle: "Ok")
            }
        }
    }
    
    private func addUserToFavorites(user: FollowerProfileModel) {
        let favorite = FollowerModel(login: user.login,
                                     avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: favorite,
                                      actionType: .add) { [weak self] error in
            guard let self = self else {
                return
            }
            
            guard let error = error else {
                self.presentAlertOnMainThread(title: "Success",
                                              message: "You have successfully favorited this user 🥳",
                                              buttonTitle: "Good")
                return
            }
            self.presentAlertOnMainThread(title: "Something went wrong",
                                          message: error.rawValue,
                                          buttonTitle: "Ok")
        }
    }
}

// MARK: - UICollectionViewDelegate
extension FollowerListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                  willDecelerate decelerate: Bool) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers,
                  !isLoadingMoreFollowers else {
                return
            }
            page += 1
            getFollowers(username: username,
                         page: page)
        }
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        navigationItem.hidesSearchBarWhenScrolling = true
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        didSelectItemAt indexPath: IndexPath) {
        let activeArray = isSearching ? filteredFollowers : followers
        let follower = activeArray[indexPath.item]
        
        let userInfoViewController = FollowerUserInfoViewController()
        userInfoViewController.username = follower.login
        userInfoViewController.delegate = self
        
        let navController = UINavigationController(rootViewController: userInfoViewController)
        present(navController, animated: true)
    }
}

// MARK: - UISearchResultsUpdating
extension FollowerListViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text,
              !filter.isEmpty else {
            filteredFollowers.removeAll()
            updateData(on: followers)
            isSearching = false
            return
        }
        isSearching = true
        filteredFollowers = followers.filter {
            $0.login.lowercased().contains(filter.lowercased())
        }
        updateData(on: filteredFollowers)
    }
}

// MARK: - FollowerListViewControllerDelegate
extension FollowerListViewController: FollowerUserInfoViewControllerDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0),
                                    at: .top, animated: true)
        getFollowers(username: username, page: page)
    }
}
