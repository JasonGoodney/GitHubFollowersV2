//
//  GFAlertView.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/19/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

protocol GFAlertViewDelegate: class {
    func alertViewDidTapActionButton()
}

class GFAlertView: UIView {
    
    private lazy var containerView: UIView = {
        let view                   = UIView()
        view.backgroundColor       = .systemBackground
        view.layer.borderWidth     = 2
        view.layer.borderColor     = UIColor.white.cgColor
        view.layer.cornerRadius    = 16
        return view
    }()
    private lazy var messageLabel: GFBodyLabel = {
        let label = GFBodyLabel(textAlignment: .center)
        label.numberOfLines = 4
        return label
    }()
    private let titleLabel      = GFTitleLabel(textAlignment: .center, fontSize: 20)
    private let actionButton    = GFButton(title: "Ok", backgroundColor: .systemPink)
    
    weak var delegate: GFAlertViewDelegate?
    

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configure()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setTitleLabel(text: String) {
        titleLabel.text = text
    }
    
    
    func setMessageLabel(text: String) {
        messageLabel.text = text
    }
    
    
    func setActionButton(text: String) {
        actionButton.setTitle(text, for: .normal)
    }
    
    
    private func configure() {
        backgroundColor = .systemDimBackground
        
        addSubviews(containerView)
        containerView.addSubviews(titleLabel, messageLabel, actionButton)
        
        
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
        
        let padding: CGFloat = 20
        
        pin(
            containerView.centerXAnchor.constraint(equalTo: centerXAnchor),
            containerView.centerYAnchor.constraint(equalTo: centerYAnchor),
            containerView.widthAnchor.constraint(equalToConstant: 280),
            containerView.heightAnchor.constraint(equalToConstant: 220),

            titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
            titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            titleLabel.heightAnchor.constraint(equalToConstant: titleLabel.safeHeight()),
            
            actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 44),
            
            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
        )
        
    }
    
    
    @objc private func actionButtonTapped() {
        delegate?.alertViewDidTapActionButton()
    }
    
}
