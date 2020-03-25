//
//  GFUserInfoVC.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/20/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

protocol GFUserInfoVCDelegate: class {
    func didRequestFollowers(forUsername username: String)
}


class GFUserInfoVC: GFDataLoadingVC, HasCustomView, GFUserInfoViewDelegate {
    typealias CustomView = GFUserInfoView

    weak var delegate: GFUserInfoVCDelegate?
    
    var username: String!
    
    
    init(username: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.username = username
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        let customView      = CustomView()
        customView.delegate = self
        view                = customView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureNavBar()
        getUserInfo()
    }
    
    
    private func getUserInfo() {
        showLoadingView()
        
        NetworkManager.shared.getUserInfo(forUsername: username) { [weak self] (result) in
            guard let self = self else { return }
            self.dismissLoadingView()
            
            switch result {
            case .success(let user):
                DispatchQueue.main.async {
                    self.configureUIElements(with: user)
                }
                
            case .failure(let error):
                self.presentAlertOnMainThread(title: "Something went wrong", message: error.rawValue)
            }
        }
    }
    
    
    private func configureNavBar() {
        let rightBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(dismissAction))
        navigationItem.rightBarButtonItem = rightBarButton
    }
    
    
    private func configureUIElements(with user: User) {
        add(childVC: GFInfoHeaderVC(user: user), to: customView.headerView)
        add(childVC: GFRepoItemInfoVC(user: user, delegate: self), to: customView.itemInfoViewOne)
        add(childVC: GFFollowerItemInfoVC(user: user, delegate: self), to: customView.itemInfoViewTwo)
        customView.setDateLabel(text: "GitHub Since \(user.createdAt.convertToMonthYearFormat())")
    }
    
    
    private func add(childVC: UIViewController, to containerView: UIView) {
        addChild(childVC)
        containerView.addSubview(childVC.view)
        childVC.view.frame = containerView.bounds
        childVC.didMove(toParent: self)
    }
}


extension GFUserInfoVC: GFRepoItemInfoVCDelegate, GFFollowerItemInfoVCDelegate {
    func didTapGitHubProfile(for user: User) {
        guard let url = URL(string: user.htmlUrl) else {
            presentAlertOnMainThread(title: "Invalid url", message: "The url for this profile is invalid")
            return
        }
        openSafari(url: url)
    }
    
    func didTapGetFollowers(for user: User) {
        guard user.followers != 0 else {
            presentAlertOnMainThread(title: "No followers", message: "This user has no followers")
            return
        }
        
        delegate?.didRequestFollowers(forUsername: user.login)
        dismissAction()
    }
}
