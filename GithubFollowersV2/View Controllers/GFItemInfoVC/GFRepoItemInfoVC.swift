//
//  GFRepoItemInfoVC.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/21/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

protocol GFRepoItemInfoVCDelegate: class {
    func didTapGitHubProfile(for user: User)
}

class GFRepoItemInfoVC: GFItemInfoVC {
    
    weak var delegate: GFRepoItemInfoVCDelegate?
    
    
    init(user: User, delegate: GFRepoItemInfoVCDelegate) {
        super.init(user: user)
        
        self.delegate = delegate
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.itemViewOne.set(itemType: .repos, withCount: user.publicRepos)
        customView.itemViewTwo.set(itemType: .gists, withCount: user.publicGists)
        customView.setActionButton(title: "GitHub Profile", backgroundColor: .systemPurple)
    }
    
    override func actionButtonTapped() {
        delegate?.didTapGitHubProfile(for: user)
    }
}
