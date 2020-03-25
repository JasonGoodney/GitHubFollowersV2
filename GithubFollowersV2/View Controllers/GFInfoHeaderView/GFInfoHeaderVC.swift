//
//  GFInfoHeaderVC.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/21/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

class GFInfoHeaderVC: UIViewController, HasCustomView {
    typealias CustomView = GFInfoHeaderView
    
    private var user: User!

    
    init(user: User) {
        super.init(nibName: nil, bundle: nil)
        
        self.user = user
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        let customView      = CustomView()
        view                = customView
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()

        configureUIElements()
    }
    
    
    private func configureUIElements() {
        customView.setTitleLabel(text: user.login)
        customView.setSubtitle1Label(text: user.name ?? "")
        customView.setSubtitle2(labelText: user.location ?? "", andSymbol: Symbols.location)
        customView.setBodyLabel(text: user.bio ?? "")
        customView.setImageView(imageUrl: user.avatarUrl)
    }

}
