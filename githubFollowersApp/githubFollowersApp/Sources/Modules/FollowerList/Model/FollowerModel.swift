//
//  FollowerModel.swift
//  githubFollowersApp
//
//  Created by Намик on 8/1/22.
//

import Foundation

struct FollowerModel: Codable, Hashable {
    var login: String
    var avatarUrl: String
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(login)
    }
}
