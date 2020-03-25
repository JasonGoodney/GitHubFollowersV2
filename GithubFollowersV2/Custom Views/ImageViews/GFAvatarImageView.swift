//
//  GFAvatarImageView.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/19/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

class GFAvatarImageView: UIImageView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    

    private func configure() {
        layer.cornerRadius = 16
        clipsToBounds = true
        
        image = Images.avatarPlaceholder
    }
    
    
    func downloadImage(fromUrl url: String) {
        NetworkManager.shared.downloadImage(fromUrl: url) { [weak self] (image) in
            guard let self = self else { return }
            DispatchQueue.main.async { self.image = image }
        }
    }
    
}
