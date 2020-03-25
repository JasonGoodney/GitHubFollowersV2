//
//  GFDataLoadingVC.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/21/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

class GFDataLoadingVC: UIViewController {

    var containerView: UIView!
    
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView)
        
        containerView.backgroundColor   = .systemBackground
        containerView.alpha             = 0
        
        UIView.animate(withDuration: 0.25) { self.containerView.alpha = 0.8 }
        
        let activityIndicator = UIActivityIndicatorView(style: .gray)
        containerView.addSubview(activityIndicator)
        
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        
        view.pin(
            activityIndicator.centerYAnchor.constraint(equalTo: containerView.centerYAnchor),
            activityIndicator.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
        )
        
        activityIndicator.startAnimating()
    }
    
    
    func dismissLoadingView() {
        guard containerView != nil else { return }
        DispatchQueue.main.async {
            self.containerView.removeFromSuperview()
            self.containerView = nil
        }
    }
    
    
    func showEmptyStateView(withMessage message: String, in view: UIView) {
        let emptyStateView = GFEmptyStateView(message: message, image: Images.emptyStateLogo)
        emptyStateView.frame = view.bounds
        view.addSubview(emptyStateView)
    }
    
}
