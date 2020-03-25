//
//  GFFavoriteCell.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/22/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

class GFFavoriteCell: UITableViewCell {
    
    static let reuseId  = String(describing: type(of: self))
    
    let avatarImageView = GFAvatarImageView(frame: .zero)
    let titleLabel      = GFTitleLabel(textAlignment: .left, fontSize: 28)
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        configure()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func set(favorite: Follower) {
        titleLabel.text = favorite.login
        avatarImageView.downloadImage(fromUrl: favorite.avatarUrl)
    }
    
    
    private func configure() {
        accessoryType = .disclosureIndicator
        
        addSubviews(avatarImageView, titleLabel)
        
        pin(
            avatarImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            avatarImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.leading),
            avatarImageView.heightAnchor.constraint(equalToConstant: 60),
            avatarImageView.widthAnchor.constraint(equalToConstant: 60),
            
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: avatarImageView.trailingAnchor, constant: 10),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.safeHeight())
        )
    }
}
