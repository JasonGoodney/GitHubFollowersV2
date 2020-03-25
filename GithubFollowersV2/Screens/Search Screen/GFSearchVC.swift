//
//  GFSearchVC.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/18/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

class GFSearchVC: UIViewController, HasCustomView {

    typealias CustomView = GFSearchView
    
    private var isUsernameEntered: Bool {
        return !customView.textField.text!.isEmpty
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
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        title = "Search"
        navigationController?.setNavigationBarHidden(true, animated: true)
    }

    
    private func configure() {
        customView.textField.delegate = self
        
        let endEditingTap = UITapGestureRecognizer(target: view, action: #selector(view.endEditing(_:)))
        view.addGestureRecognizer(endEditingTap)
    }

    
    @objc private func pushFollowerListVC() {
        guard isUsernameEntered else {
            customView.emptyTextFieldWarning(hidden: false)
//            self.presentAlertOnMainThread(title: "Empty username", message: "Please enter a username. We need to know who to look for 😀.")
            return
        }
        
        let username        = customView.textField.text!
        let followerListVC  = GFFollowerListVC(username: username)
        navigationController?.pushViewController(followerListVC, animated: true)
        
        customView.textField.resignFirstResponder()
    }
}


extension GFSearchVC: GFSearchViewDelegate {
    
    func searchViewDidTapActionButton() {
        pushFollowerListVC()
    }
}


extension GFSearchVC: UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pushFollowerListVC()
        
        return true
    }
    
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        customView.emptyTextFieldWarning(hidden: true)
    }
    
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if let text = textField.text, !text.isEmpty {
            customView.emptyTextFieldWarning(hidden: true)
        }
        
        return true
    }
}
