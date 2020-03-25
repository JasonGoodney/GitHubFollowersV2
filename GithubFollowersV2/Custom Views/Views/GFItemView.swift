//
//  GFItemView.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/21/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

enum GFItemType {
    
    case repos, gists, following, followers
}


class GFItemView: UIView {

    private let symbolView: UIImageView = {
        let symbolView          = UIImageView()
        symbolView.contentMode  = .scaleAspectFill
        symbolView.tintColor    = .label
        return symbolView
    }()
    private let titleLabel      = GFTitleLabel(textAlignment: .left, fontSize: 14)
    private let subtitleLabel   = GFTitleLabel(textAlignment: .center, fontSize: 14)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func configure() {
        addSubviews(symbolView, titleLabel, subtitleLabel)
        
        pin(
            symbolView.topAnchor.constraint(equalTo: topAnchor),
            symbolView.leadingAnchor.constraint(equalTo: leadingAnchor),
            symbolView.widthAnchor.constraint(equalToConstant: 20),
            symbolView.heightAnchor.constraint(equalToConstant: 20),
            
            titleLabel.centerYAnchor.constraint(equalTo: symbolView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: symbolView.trailingAnchor, constant: 12),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.safeHeight()),
            
            subtitleLabel.topAnchor.constraint(equalTo: symbolView.bottomAnchor, constant: 4),
            subtitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitleLabel.heightAnchor.constraint(equalToConstant: titleLabel.safeHeight())
        )
    }
    
    
    func set(itemType: GFItemType, withCount count: Int) {
        switch itemType {
        case .repos:
            titleLabel.text     = "Public Repos"
            symbolView.image    = Symbols.repos
        case .gists:
            titleLabel.text     = "Public Gists"
            symbolView.image    = Symbols.gists
        case .following:
            titleLabel.text     = "Following"
            symbolView.image    = Symbols.following
        case .followers:
            titleLabel.text     = "Followers"
            symbolView.image    = Symbols.followers
        }
        
        subtitleLabel.text = String(count)
    }
}
