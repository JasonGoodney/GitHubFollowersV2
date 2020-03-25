//
//  GFItemInfoVC.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/21/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

class GFItemInfoVC: UIViewController, HasCustomView {
    typealias CustomView = GFItemInfoView
    
    var user: User!
    
    
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
        
        customView.actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }

    
    @objc func actionButtonTapped() {}
    
}
