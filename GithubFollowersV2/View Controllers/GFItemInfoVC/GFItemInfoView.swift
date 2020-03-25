//
//  GFItemInfoView.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/21/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

class GFItemInfoView: GFView {

    lazy var stackView: UIStackView = {
        let stackView           = UIStackView(arrangedSubviews: [itemViewOne, itemViewTwo])
        stackView.axis          = .horizontal
        stackView.distribution  = .equalSpacing
        return stackView
    }()
    let itemViewOne     = GFItemView()
    let itemViewTwo     = GFItemView()
    let actionButton    = GFButton()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setActionButton(title: String, backgroundColor: UIColor) {
        actionButton.setTitle(title, for: .normal)
        actionButton.backgroundColor = backgroundColor
    }
    
    
    
    private func configure() {
        layer.cornerRadius  = 16
        backgroundColor     = .secondarySystemBackground
        
        addSubviews(stackView, actionButton)
        
        pin(
            stackView.topAnchor.constraint(equalTo: topAnchor, constant: Padding.top),
            stackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.leading),
            stackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.trailing),
            stackView.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: bottomAnchor, constant: Padding.bottom),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.leading),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.trailing),
            actionButton.heightAnchor.constraint(equalToConstant: 44)
        )
    }
}
