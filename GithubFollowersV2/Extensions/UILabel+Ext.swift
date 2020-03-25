//
//  UILabel+Ext.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/23/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

extension UILabel {
    
    func safeHeight(additionalHeight: CGFloat = 4) -> CGFloat {
        return self.font.pointSize + additionalHeight
    }
}
