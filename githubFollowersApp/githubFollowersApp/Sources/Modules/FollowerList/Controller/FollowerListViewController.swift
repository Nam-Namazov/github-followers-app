//
//  FollowerListViewController.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import UIKit

final class FollowerListViewController: UIViewController {
    enum Section {
        case main
    }
    
    var username: String?
    var followers: [FollowerModel] = []
    private var followerListСollectionView: UICollectionView!
    private var dataSource: UICollectionViewDiffableDataSource<Section, FollowerModel>!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        style()
        configureCollectionView()
        getFollowers()
        configureDataSource()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    private func style() {
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    private func configureCollectionView() {
        followerListСollectionView = UICollectionView(frame: view.bounds,
                                                      collectionViewLayout: createThreeColumnFlowLayout())
        view.addSubview(followerListСollectionView)
        followerListСollectionView.backgroundColor = .systemPink

        followerListСollectionView.register(FollowerListCollectionViewCell.self,
                                            forCellWithReuseIdentifier: FollowerListCollectionViewCell.identifier)
    }
    
    private func getFollowers() {
        guard let username = username else {
            return
        }
        NetworkManager.shared.getFollowers(for: username, page: 1) { result in
            switch result {
                
            case .success(let followers):
                self.followers = followers
                self.updateData()
                
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Bad Stuff Happened",
                                              message: error.rawValue,
                                              buttonTitle: "Ok")
            }
        }
    }
    
    private func createThreeColumnFlowLayout()  -> UICollectionViewFlowLayout {
        let width = view.bounds.width
        let padding: CGFloat = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth = availableWidth / 3
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.sectionInset = UIEdgeInsets(top: padding,
                                               left: padding,
                                               bottom: padding,
                                               right: padding)
        flowLayout.itemSize = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }
    

    
    private func configureDataSource() {
        dataSource = UICollectionViewDiffableDataSource<Section, FollowerModel>(collectionView: followerListСollectionView, cellProvider: { (collectionView, indexPath, follower) -> UICollectionViewCell? in
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: FollowerListCollectionViewCell.identifier, for: indexPath) as? FollowerListCollectionViewCell else {
                return UICollectionViewCell()
            }
            cell.configure(follower: follower)
            return cell
        })
    }
    
    private func updateData() {
        var snapshot = NSDiffableDataSourceSnapshot<Section, FollowerModel>()
        snapshot.appendSections([.main])
        snapshot.appendItems(followers)
        DispatchQueue.main.async {
            self.dataSource.apply(snapshot, animatingDifferences: true)
        }
    }
}
