//
//  Result.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/19/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import Foundation

enum Result<Success, Failure> where Failure: Error {
    
    case success(Success)
    case failure(Failure)
}
