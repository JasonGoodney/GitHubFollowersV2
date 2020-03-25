//
//  GFFollowerListCell.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/19/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

class GFFollowerListCell: UICollectionViewCell {
    
    static let reuseId          = String(describing: type(of: self))
    
    private let avatarImageView = GFAvatarImageView(frame: .zero)
    private let titleLabel      = GFTitleLabel(textAlignment: .center, fontSize: 16)

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(follower: Follower) {
        titleLabel.text = follower.login
        avatarImageView.downloadImage(fromUrl: follower.avatarUrl)
    }
    
    
    private func configure() {
        addSubviews(avatarImageView, titleLabel)
        
        let padding: CGFloat = 12
        
        pin(
            avatarImageView.topAnchor.constraint(equalTo: topAnchor, constant: padding),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            avatarImageView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            avatarImageView.heightAnchor.constraint(equalTo: avatarImageView.widthAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: avatarImageView.bottomAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.safeHeight())
        )
    }
}
