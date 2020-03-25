//
//  GFAlertVC.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/19/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

class GFAlertVC: UIViewController, HasCustomView {
    typealias CustomView = GFAlertView
    
    private var alertTitle: String!
    private var alertMessage: String!
    private var buttonTitle: String!

    
    init(alertTitle: String, alertMessage: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        
        self.alertTitle     = alertTitle
        self.alertMessage   = alertMessage
        self.buttonTitle    = buttonTitle
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func loadView() {
        let customView      = CustomView()
        customView.delegate = self
        view                = customView
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configure()
    }
    
    
    private func configure() {
        customView.setTitleLabel(text: alertTitle)
        customView.setMessageLabel(text: alertMessage)
        customView.setActionButton(text: buttonTitle)
    }
}


extension GFAlertVC: GFAlertViewDelegate {
    func alertViewDidTapActionButton() {
        dismiss(animated: true)
    }
}
