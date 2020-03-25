//
//  UICollectionView+Ext.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/19/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

extension UICollectionView {
    
    func reloadDataOnMainThread(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.reloadData()
        }
        
        if let completion = completion {
            completion()
        }
    }
}
