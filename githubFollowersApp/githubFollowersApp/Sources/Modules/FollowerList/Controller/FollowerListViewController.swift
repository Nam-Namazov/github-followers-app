//
//  FollowerListViewController.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import UIKit

protocol FollowerListViewControllerDelegate: AnyObject {
    func didRequestFollowers(for username: String)
}

final class FollowerListViewController: UIViewController {
    enum Section {
        case main
    }
    
    var username: String!
    private var followers: [FollowerModel] = []
    private var page = 1
    private var hasMoreFollowers = true
    private var collectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, FollowerModel>!
    private var filteredFollowers: [FollowerModel] = []
    private var isSearching = false
    
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
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        searchController.searchBar.placeholder = "Search for a username"
        navigationItem.searchController = searchController
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
    }
    
    private func getFollowers(username: String, page: Int) {
        showLoadingView()
        NetworkManager.shared.getFollowers(for: username,
                                           page: page) { [weak self] result in
            guard let self = self else {
                return
            }
            self.dismissLoadingView()
            
            switch result {
            case .success(let followers):
                if followers.count < 100 {
                    self.hasMoreFollowers = false
                }
                self.followers.append(contentsOf: followers)
                if self.followers.isEmpty {
                    let text = "This user doesn't have any followers. Go follow them 😇"
                    
                    DispatchQueue.main.async {
                        self.showEmptyStateView(with: text, in: self.view)
                    }
                    return
                }
                self.updateData(on: self.followers)
                
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Bad Stuff Happened",
                                              message: error.rawValue,
                                              buttonTitle: "Ok")
            }
        }
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
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
    
    private func configureRightNavBarItemButton() {
        let addButton = UIBarButtonItem(barButtonSystemItem: .add,
                                        target: self,
                                        action: #selector(handleAddTapButton))
        navigationItem.rightBarButtonItem = addButton
    }
    
    @objc private func handleAddTapButton() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(for: username) { [weak self] result in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                let favorite = FollowerModel(login: user.login,
                                             avatarUrl: user.avatarUrl)
                
                PersistenceManager.updateWith(favorite: favorite,
                                              actionType: .add) { [weak self] error in
                    guard let self = self,
                          let error = error else {
                        self?.presentAlertOnMainThread(title: "Success",
                                                       message: "You have successfully favorited this user 🥳",
                                                       buttonTitle: "Good")
                        return
                    }
                    self.presentAlertOnMainThread(title: "Something went wrong",
                                                  message: error.rawValue,
                                                  buttonTitle: "Ok")
                }
                
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong",
                                              message: error.rawValue,
                                              buttonTitle: "Ok")
            }
        }
    }
}

// MARK: - UICollectionViewDelegate
extension FollowerListViewController: UICollectionViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView,
                                  willDecelerate decelerate: Bool) {
        // offsetY - how far scroll
        // contentHeight - all height of all users
        // height - heigt of the screen
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let height = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers else { return }
            page += 1
            getFollowers(username: username, page: page)
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
            return
        }
        isSearching = true
        filteredFollowers = followers.filter {
            $0.login.lowercased().contains(filter.lowercased())
        }
        updateData(on: filteredFollowers)
    }
}

// MARK: - UISearchBarDelegate
extension FollowerListViewController: UISearchBarDelegate {
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
        updateData(on: followers)
    }
}

// MARK: - FollowerListViewControllerDelegate
extension FollowerListViewController: FollowerListViewControllerDelegate {
    func didRequestFollowers(for username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.setContentOffset(.zero, animated: true)
        getFollowers(username: username, page: page)
    }
}
