//
//  Constants.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/18/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

enum Symbols {
    
    static let location                             = UIImage(named: "icons8-place_marker")
    static let repos                                = UIImage(named: "icons8-folder_invoices")
    static let gists                                = UIImage(named: "icons8-align_left")
    static let following                            = UIImage(named: "icons8-hearts")
    static let followers                            = UIImage(named: "icons8-myspace")
}


enum Images {
    
    static let ghLogo                               = UIImage(named: "gh-logo")
    static let emptyStateLogo                       = UIImage(named: "empty-state-logo")
    static let avatarPlaceholder                    = UIImage(named: "avatar-placeholder")
}


enum Padding {
    
    static let system: CGFloat                      = 20
    static let secondarySystem: CGFloat             = 12
    
    static let top: CGFloat                   = Padding.system
    static let leading: CGFloat               = Padding.system
    static let trailing: CGFloat              = -Padding.system
    static let bottom: CGFloat                = -Padding.system
    
    static let secondaryTop: CGFloat          = Padding.secondarySystem
    static let secondaryLeading: CGFloat      = Padding.secondarySystem
    static let secondaryTrailing: CGFloat     = -Padding.secondarySystem
    static let secondaryBottom: CGFloat       = -Padding.secondarySystem
}

