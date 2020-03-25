//
//  GFBodyLabel.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/19/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

class GFBodyLabel: UILabel {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(textAlignment: NSTextAlignment) {
        self.init(frame: .zero)
        
        self.textAlignment = textAlignment
    }
    
    
    private func configure() {
        textColor                           = .secondaryLabel
        adjustsFontSizeToFitWidth           = true
        adjustsFontForContentSizeCategory   = true
        minimumScaleFactor                  = 0.75
        lineBreakMode                       = .byWordWrapping
        font                                = UIFont.preferredFont(forTextStyle: .body)
    }

}
