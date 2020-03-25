//
//  GFInfoHeaderView.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/20/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

class GFInfoHeaderView: UIView {

    private lazy var imageView: GFAvatarImageView = {
        let imageView = GFAvatarImageView(frame: .zero)
        return imageView
    }()
    private lazy var titleLabel: GFTitleLabel = {
        let label = GFTitleLabel(textAlignment: .left, fontSize: 34)
        return label
    }()
    private lazy var subtitle1Label: GFSecondaryTitleLabel = {
        let label = GFSecondaryTitleLabel(fontSize: 18)
        return label
    }()
    private lazy var subtitle2SymbolView: UIImageView = {
        let imageView = UIImageView()
        imageView.tintColor = .secondaryLabel
        return imageView
    }()
    private lazy var subtitle2Label: GFSecondaryTitleLabel = {
        let label = GFSecondaryTitleLabel(fontSize: 18)
        return label
    }()
    private lazy var bodyLabel: GFBodyLabel = {
        let label = GFBodyLabel(textAlignment: .left)
        label.numberOfLines = 3
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(imageView, titleLabel, subtitle1Label, subtitle2SymbolView, subtitle2Label, bodyLabel)
        configure()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setTitleLabel(text: String) {
        titleLabel.text = text
    }
    
    
    func setSubtitle1Label(text: String) {
        subtitle1Label.text = text
    }
    
    
    func setSubtitle2(labelText text: String, andSymbol symbol: UIImage?) {
        subtitle2Label.text = text
        
        if !text.isEmpty {
            subtitle2SymbolView.image = symbol?.withRenderingMode(.alwaysTemplate)
        }
    }
    
    
    func setBodyLabel(text: String) {
        bodyLabel.text = text
    }
    
    func setImageView(image: UIImage? = nil, imageUrl: String? = nil) {
        if let image = image {
            imageView.image = image
            return
        }
        
        if let imageUrl = imageUrl {
            imageView.downloadImage(fromUrl: imageUrl)
            return
        }
    }
    
    
    private func configure() {
        pin(
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 90),
            imageView.heightAnchor.constraint(equalToConstant: 90),
            
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Padding.secondaryLeading),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.safeHeight()),
            
            subtitle1Label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor, constant: 8),
            subtitle1Label.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Padding.secondaryLeading),
            subtitle1Label.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitle1Label.heightAnchor.constraint(equalToConstant: subtitle1Label.safeHeight()),
            
            subtitle2SymbolView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            subtitle2SymbolView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Padding.secondaryLeading),
            subtitle2SymbolView.widthAnchor.constraint(equalToConstant: 20),
            subtitle2SymbolView.heightAnchor.constraint(equalToConstant: 20),
            
            subtitle2Label.centerYAnchor.constraint(equalTo: subtitle2SymbolView.centerYAnchor),
            subtitle2Label.leadingAnchor.constraint(equalTo: subtitle2SymbolView.trailingAnchor, constant: 4),
            subtitle2Label.trailingAnchor.constraint(equalTo: trailingAnchor),
            subtitle2Label.heightAnchor.constraint(equalToConstant: subtitle2Label.safeHeight()),
            
            bodyLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: Padding.secondaryTop),
            bodyLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor),
            bodyLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            bodyLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Padding.secondaryBottom),
            bodyLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 0)
        )
    }
    
}
