//
//  GFError.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/19/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import Foundation

enum GFError: String, Error {
 
    case invalidUsername        = "This username created an invalid request. Please try again."
    case invalidResponse        = "Invalid response from server. Please try again."
    case invalidData            = "That data received from the server was invalid. Please try again."
    case unableToComplete       = "Unable to complete your request. Please check your internet connection."
   
    case unableToFavorite       = "Unable able to favorite user. Please try again."
    case alreadyInFavorites     = "You have already favorited this user."
    case noFavorites            = "No Favorites 😕.\nFavorited users will appear here."
}
