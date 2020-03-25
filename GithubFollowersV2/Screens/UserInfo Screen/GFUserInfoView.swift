//
//  GFUserInfoView.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/20/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

protocol GFUserInfoViewDelegate: class {}

class GFUserInfoView: GFView {

    let headerView      = UIView()
    let itemInfoViewOne = UIView()
    let itemInfoViewTwo = UIView()
    let dateLabel       = GFBodyLabel(textAlignment: .center)
    
    weak var delegate: GFUserInfoViewDelegate?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
   
    
    func setDateLabel(text: String) {
        dateLabel.text = text
    }
    
    
    private func configure() {
        addSubviews(headerView, itemInfoViewOne, itemInfoViewTwo, dateLabel)
        
        pin(
            headerView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: Padding.top),
            headerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.leading),
            headerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.trailing),
            headerView.heightAnchor.constraint(equalToConstant: 180),
            
            itemInfoViewOne.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: Padding.top),
            itemInfoViewOne.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.leading),
            itemInfoViewOne.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.trailing),
            itemInfoViewOne.heightAnchor.constraint(equalToConstant: 140),
            
            itemInfoViewTwo.topAnchor.constraint(equalTo: itemInfoViewOne.bottomAnchor, constant: Padding.top),
            itemInfoViewTwo.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.leading),
            itemInfoViewTwo.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.trailing),
            itemInfoViewTwo.heightAnchor.constraint(equalToConstant: 140),
            
            dateLabel.topAnchor.constraint(equalTo: itemInfoViewTwo.bottomAnchor, constant: Padding.top),
            dateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: Padding.leading),
            dateLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: Padding.trailing),
            dateLabel.heightAnchor.constraint(equalToConstant: dateLabel.safeHeight())
        )
    }
}
