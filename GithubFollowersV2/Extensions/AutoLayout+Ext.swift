//
//  AutoLayout+Ext.swift
//  GithubFollowersV2
//
//  Created by Brian Voong
//
//

import UIKit

extension UIView {
    
    func pin(_ constraints: NSLayoutConstraint...) {
        constraints.forEach({ $0.isActive = true })
    }
}
