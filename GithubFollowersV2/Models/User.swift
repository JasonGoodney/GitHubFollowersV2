//
//  User.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/19/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import Foundation

struct User: Codable {
    let login: String
    let avatarUrl: String
    let htmlUrl: String
    let publicRepos: Int
    let publicGists: Int
    let followers: Int
    let following: Int
    let createdAt: Date
    
    var name: String?
    var bio: String?
    var location: String?
}
