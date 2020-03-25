//
//  UITableView+Ext.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/19/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

extension UITableView {
    
    func reloadDataOnMainThread(completion: (() -> Void)? = nil) {
        DispatchQueue.main.async {
            self.reloadData()
        }
        
        if let completion = completion {
            completion()
        }
    }
    
    
    func deselectSelectedRow(animated: Bool)
    {
        if let indexPathForSelectedRow = self.indexPathForSelectedRow {
            self.deselectRow(at: indexPathForSelectedRow, animated: animated)
        }
    }
}
