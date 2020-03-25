//
//  GFFollowerItemInfoVC.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/21/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

protocol GFFollowerItemInfoVCDelegate: class {
    func didTapGetFollowers(for user: User)
}

class GFFollowerItemInfoVC: GFItemInfoVC {
    
    weak var delegate: GFFollowerItemInfoVCDelegate?
    
    
    init(user: User, delegate: GFFollowerItemInfoVCDelegate) {
        super.init(user: user)
        
        self.delegate = delegate
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        customView.itemViewOne.set(itemType: .following, withCount: user.following)
        customView.itemViewTwo.set(itemType: .followers, withCount: user.followers)
        customView.setActionButton(title: "Get Followers", backgroundColor: .systemGreen)
    }
    
    
    override func actionButtonTapped() {
        delegate?.didTapGetFollowers(for: user)
    }
}

