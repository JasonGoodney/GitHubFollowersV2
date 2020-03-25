//
//  GFFavoriteListVC.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/22/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

class GFFavoriteListVC: GFDataLoadingVC {

    private lazy var tableView: UITableView = {
        let tableView               = UITableView(frame: view.bounds, style: .plain)
        tableView.tableFooterView   = UIView()
        tableView.delegate          = self
        tableView.dataSource        = self
        tableView.rowHeight         = 80
        tableView.register(GFFavoriteCell.self, forCellReuseIdentifier: GFFavoriteCell.reuseId)
        return tableView
    }()
    
    var favorites: [Follower] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubviews(tableView)
        configureNavBar()
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        
        tableView.deselectSelectedRow(animated: true)
        retrieveFavoritesFromPersistance()
    }
    
    
    private func retrieveFavoritesFromPersistance() {
        PersistenceManager.retrieveFavorites { [weak self] (result) in
            guard let self = self else { return }
            
            switch result {
            case .success(let favorites):
                self.favorites = favorites
                self.tableView.reloadDataOnMainThread()
            case .failure(let error):
                self.showEmptyStateView(withMessage: error.rawValue, in: self.view)
            }
        }
    }
    
    
    private func configureNavBar() {
        title = "Favorites"
        navigationController?.navigationBar.prefersLargeTitles = true
    }

}


extension GFFavoriteListVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return favorites.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: GFFavoriteCell.reuseId, for: indexPath) as! GFFavoriteCell
        
        let favorite = favorites[indexPath.row]
        cell.set(favorite: favorite)
        
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let favorite            = favorites[indexPath.row]
        let destinationVC       = GFFollowerListVC(username: favorite.login)
        
        navigationController?.pushViewController(destinationVC, animated: true)
    }
    
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        guard editingStyle == .delete else { return }
        
        let favorite = favorites[indexPath.row]
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .remove) { [weak self] (error) in
            guard let self = self else { return }
            
            if let error = error {
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue)
                return
            }
            
            self.favorites.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}
