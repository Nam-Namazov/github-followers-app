//
//  FavoritesListVC.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import UIKit

final class FavoritesListViewController: DataLoadingViewController {
    private let tableView = UITableView()
    private var favorites: [FollowerModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        configureTableView()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        getFavorites()
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureTableView() {
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FavoritesTableViewCell.self,
                           forCellReuseIdentifier: FavoritesTableViewCell.identifier)
    }
    
    private func getFavorites() {
        PersistenceManager.retrieveFavorites { [weak self] result in
            guard let self = self else {
                return
            }
            
            switch result {
            case .success(let favorites):
                self.updateUI(with: favorites)
                
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong",
                                              message: error.rawValue,
                                              buttonTitle: "Ok")
            }
        }
    }
    
    private func updateUI(with favorites: [FollowerModel]) {
        if favorites.isEmpty {
            self.showEmptyStateView(with: "No favorites? \nAdd one on the follower screen 🧐",
                                    in: self.view)
        } else {
            self.favorites = favorites
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.view.bringSubviewToFront(self.tableView)
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension FavoritesListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FavoritesTableViewCell.identifier, for: indexPath) as? FavoritesTableViewCell else {
            return UITableViewCell()
        }
        let favorite = favorites[indexPath.row]
        
        cell.set(favorite: favorite)
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension FavoritesListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let favorite = favorites[indexPath.row]
        let followerListViewController = FollowerListViewController(username: favorite.login)
        
        navigationController?.pushViewController(followerListViewController,
                                                 animated: true)
    }
    
    func tableView(_ tableView: UITableView,
                   commit editingStyle: UITableViewCell.EditingStyle,
                   forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else {
            return
        }
        
        PersistenceManager.updateWith(favorite: favorites[indexPath.row],
                                      actionType: .remove) { [weak self] error in
            guard let self = self,
                  let error = error else {
                self?.favorites.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .top)
                return
            }
            self.presentAlertOnMainThread(title: "Unable to remove",
                                          message: error.rawValue,
                                          buttonTitle: "Ok")
        }
    }
    
    func tableView(_ tableView: UITableView,
                   heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}
