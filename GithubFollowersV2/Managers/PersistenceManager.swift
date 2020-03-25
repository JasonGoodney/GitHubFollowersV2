//
//  PersistenceManager.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/22/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import Foundation

enum PersistenceActionType {
    case add, remove
}


enum PersistenceManager {
    
    static private let defaults = UserDefaults.standard
    enum Keys { static let favorites = "Favorites" }
 
    
    static func updateWith(favorite: Follower, actionType: PersistenceActionType, completion: @escaping (GFError?) -> Void) {
        
        retrieveFavorites { (result) in
            
            switch result {
            case .success(var retrievedFavorites):
                switch actionType {
                case .add:
                    if retrievedFavorites.contains(favorite) {
                        completion(.alreadyInFavorites)
                        return
                    }
                    
                    retrievedFavorites.append(favorite)
                    
                case .remove:
                    retrievedFavorites.removeAll(where: { $0 == favorite })
                }
                

                completion(save(favorites: retrievedFavorites))
                
            case .failure(let error):
                completion(error)
            }
        }
    }
    
    
    static func retrieveFavorites(completion: @escaping (Result<[Follower], GFError>) -> Void) {
        guard let savedData = PersistenceManager.defaults.object(forKey: Keys.favorites) as? Data else {
            completion(.failure(.noFavorites))
            return
        }
        
        do {
            let decoder = JSONDecoder()
            let favorites = try decoder.decode([Follower].self, from: savedData)
            completion(.success(favorites))
        } catch {
            completion(.failure(.unableToFavorite))
        }
    }
    
    
    static func save(favorites: [Follower]) -> GFError? {
        do {
            let encoder = JSONEncoder()
            let encodedData = try encoder.encode(favorites)
            PersistenceManager.defaults.set(encodedData, forKey: Keys.favorites)
            return nil
        } catch {
            return .unableToFavorite
        }
    }
    
}
