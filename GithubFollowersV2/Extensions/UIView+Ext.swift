//
//  UIView+Ext.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/18/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

extension UIView {
    
    func addSubviews(_ views: UIView..., translatesAutoresizingMaskIntoConstraints: Bool = false) {
        views.forEach({
            addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        })
    }
}
