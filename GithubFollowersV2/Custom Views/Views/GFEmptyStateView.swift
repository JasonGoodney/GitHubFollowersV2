//
//  GFEmptyStateView.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/21/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

class GFEmptyStateView: GFView {

    let imageView = UIImageView()
    let messageLabel: GFTitleLabel = {
        let label           = GFTitleLabel(textAlignment: .center, fontSize: 28)
        label.numberOfLines = 3
        label.textColor     = .secondaryLabel
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    convenience init(message: String, image: UIImage?) {
        self.init(frame: .zero)
        
        messageLabel.text   = message
        imageView.image     = image
    }
    
    
    private func configure() {
        addSubviews(messageLabel, imageView)
        
        pin(
            messageLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -150),
            messageLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 40),
            messageLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -40),
            messageLabel.heightAnchor.constraint(equalToConstant: 200),
            
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 170),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 40),
            imageView.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3),
            imageView.heightAnchor.constraint(equalTo: widthAnchor, multiplier: 1.3)
        )
    }
}
