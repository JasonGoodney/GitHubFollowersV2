//
//  GFFollowerListVC.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/18/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

class GFFollowerListVC: GFDataLoadingVC {

    private lazy var flowLayout: UICollectionViewFlowLayout = {
        let width                       = view.bounds.width
        let padding: CGFloat            = 12
        let minimumItemSpacing: CGFloat = 10
        let availableWidth              = width - (padding * 2) - (minimumItemSpacing * 2)
        let itemWidth                   = availableWidth / 3
        
        let flowLayout                  = UICollectionViewFlowLayout()
        flowLayout.sectionInset         = UIEdgeInsets(top: padding, left: padding, bottom: padding, right: padding)
        flowLayout.itemSize             = CGSize(width: itemWidth, height: itemWidth + 40)
        return flowLayout
    }()
    
    private lazy var collectionView: UICollectionView = {
        let collectionView              = UICollectionView(frame: view.bounds, collectionViewLayout: flowLayout)
        collectionView.delegate         = self
        collectionView.dataSource       = self
        collectionView.backgroundColor  = .systemBackground
        collectionView.register(GFFollowerListCell.self, forCellWithReuseIdentifier: GFFollowerListCell.reuseId)
        return collectionView
    }()
    
    private var username: String!
    private var followers: [Follower]           = []
    private var filteredFollowers: [Follower]   = []
    private var page                            = 1
    private var isSearching                     = false
    private var hasMoreFollowers                = true
    private var isLoadingMoreFollowers          = false
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)

        self.username   = username
        title           = username
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubviews(collectionView)
        configureNavBar()
        getFollowers(forUsername: username)
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    
    private func getFollowers(forUsername username: String) {
        isLoadingMoreFollowers = true
        showLoadingView()
        self.addButton(enabled: false)
        
        NetworkManager.shared.getFollowers(for: username, page: page) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            self.addButton(enabled: true)
            
            switch result {
            case .success(let followers):
                self.updateUI(with: followers)

            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
            
            self.isLoadingMoreFollowers = false
        }
    }
    
    
    private func updateUI(with followers: [Follower]) {
        if followers.count < NetworkManager.shared.perPageCount { hasMoreFollowers = false }
        
        if followers.isEmpty {
            let message = "This user doesn't have any followers. Go follow them 😀."
            DispatchQueue.main.async {
                self.showEmptyStateView(withMessage: message, in: self.view)
            }
        }
        
        self.followers.append(contentsOf: followers)
        self.collectionView.reloadDataOnMainThread()
    }
    
    
    private func configureNavBar() {
        navigationController?.navigationBar.prefersLargeTitles  = true
        let rightBarButton                                      = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addButtonTapped))
        navigationItem.rightBarButtonItem                       = rightBarButton
        
        let searchController                                    = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater                   = self
        searchController.searchBar.placeholder                  = "Search for a username"
        searchController.obscuresBackgroundDuringPresentation   = false
        navigationItem.searchController                         = searchController
    }


    @objc private func addButtonTapped() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(forUsername: username) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                self.addUserToFavorites(user: user)
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
            
        }
    }
    
    
    private func addUserToFavorites(user: User) {
        let favorite = Follower(login: user.login, avatarUrl: user.avatarUrl)
        
        PersistenceManager.updateWith(favorite: favorite, actionType: .add) { [weak self] (error) in
            guard let self = self else { return }
            
            if let error = error {
                self.presentToastOnMainThread(message: error.rawValue, ofType: .error)
                
            } else {
                let message = "\(user.login) is saved to your favorites."
                self.presentToastOnMainThread(message: message, ofType: .success)
            }
        }
    }
    
    
    private func addButton(enabled: Bool) {
        if enabled {
            DispatchQueue.main.async {
                self.navigationItem.rightBarButtonItem?.isEnabled = true
            }
        } else {
            navigationItem.rightBarButtonItem?.isEnabled = false
        }
    }
}


extension GFFollowerListVC: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return isSearching ? filteredFollowers.count : followers.count
    }
    
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell            = collectionView.dequeueReusableCell(withReuseIdentifier: GFFollowerListCell.reuseId, for: indexPath) as! GFFollowerListCell
        
        let activeArray     = isSearching ? filteredFollowers : followers
        
        if !activeArray.isEmpty {
            cell.set(follower: activeArray[indexPath.row])
        }
        
        return cell
    }
    
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let activeArray         = isSearching ? filteredFollowers : followers
        let follower            = activeArray[indexPath.row]
        
        let destinationVC       = GFUserInfoVC(username: follower.login)
        destinationVC.delegate  = self
        let navVC               = UINavigationController(rootViewController: destinationVC)
        present(navVC, animated: true)
    }
}


extension GFFollowerListVC: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let filter = searchController.searchBar.text, !filter.isEmpty else {
            isSearching = false
            filteredFollowers.removeAll()
            self.collectionView.reloadDataOnMainThread()
            return
        }
        
        isSearching         = true
        filteredFollowers   = followers.filter({ $0.login.lowercased().contains(filter.lowercased()) })
        self.collectionView.reloadDataOnMainThread()
    }
}


extension GFFollowerListVC: UIScrollViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let offsetY         = scrollView.contentOffset.y
        let contentHeight   = scrollView.contentSize.height
        let height          = scrollView.frame.size.height
        
        if offsetY > contentHeight - height {
            guard hasMoreFollowers, !isLoadingMoreFollowers else { return }
            page += 1
            getFollowers(forUsername: username)
        }
    }
}


extension GFFollowerListVC: GFUserInfoVCDelegate {
    
    func didRequestFollowers(forUsername username: String) {
        self.username = username
        title = username
        page = 1
        followers.removeAll()
        filteredFollowers.removeAll()
        collectionView.scrollToItem(at: IndexPath(item: 0, section: 0), at: .top, animated: true)
        
        getFollowers(forUsername: username)
    }
}
