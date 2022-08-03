//
//  FollowerProfileModel.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import Foundation

struct FollowerProfileModel: Codable {
    let login: String
    let avatarUrl: String
    var name: String?
    var location: String?
    var bio: String?
    let publicRepos: Int
    let publicGists: Int
    let htmlUrl: String
    let following: Int
    let followers: Int
    let createdAt: Date
}
