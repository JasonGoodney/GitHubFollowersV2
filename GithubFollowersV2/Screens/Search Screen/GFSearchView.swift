//
//  GFSearchView.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/18/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

protocol GFSearchViewDelegate: class {
    func searchViewDidTapActionButton()
}

class GFSearchView: GFView {

    let logoImageView   = UIImageView()
    let actionButton    = GFButton(title: "Get Followers", backgroundColor: .systemGreen)
    let textField       = GFTextField(placeholder: "Enter a username")
    lazy var errorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemRed
        label.text = "Please enter a username.\nWe need to know who to look for 😀."
        label.numberOfLines = 2
        label.sizeToFit()
        label.alpha = 0
        return label
    }()
    
    weak var delegate: GFSearchViewDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        addSubviews(logoImageView, actionButton, textField, errorLabel)
        configure()
        layoutUI()
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func emptyTextFieldWarning(hidden: Bool) {
        if hidden {
            UIView.animate(withDuration: 0.25) {
                self.errorLabel.alpha = 0
            }
        } else {
            UIView.animate(withDuration: 0.25) {
                self.errorLabel.alpha = 1
            }
        }
    }
    
    
    private func configure() {
        logoImageView.image = Images.ghLogo
        actionButton.addTarget(self, action: #selector(actionButtonTapped), for: .touchUpInside)
    }
    
    
    private func layoutUI() {
        logoImageView.translatesAutoresizingMaskIntoConstraints = false
        
        let padding: CGFloat = Padding.system * 2
        
        pin(
            logoImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
            logoImageView.topAnchor.constraint(equalTo: topAnchor, constant: 100),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            
            textField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: padding),
            textField.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            textField.heightAnchor.constraint(equalToConstant: 50),
            
            actionButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -padding),
            actionButton.leadingAnchor.constraint(equalTo: leadingAnchor, constant: padding),
            actionButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -padding),
            actionButton.heightAnchor.constraint(equalToConstant: 50),
            
            errorLabel.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 4),
            errorLabel.leadingAnchor.constraint(equalTo: textField.leadingAnchor, constant: 4),
            errorLabel.trailingAnchor.constraint(equalTo: textField.trailingAnchor, constant: -4)
            
        )
    }
    
    
    @objc private func actionButtonTapped() {
        delegate?.searchViewDidTapActionButton()
    }
}
