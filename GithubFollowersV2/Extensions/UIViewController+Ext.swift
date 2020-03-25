//
//  UIViewController+Ext.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/19/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit
import SafariServices

extension UIViewController {
    
    func presentAlertOnMainThread(title: String, message: String, buttonTitle: String = "Ok") {
        DispatchQueue.main.async {
            let alertVC = GFAlertVC(alertTitle: title, alertMessage: message, buttonTitle: buttonTitle)
            alertVC.modalTransitionStyle    = .crossDissolve
            alertVC.modalPresentationStyle  = .overFullScreen
            self.present(alertVC, animated: true)
        }
    }
    
    
    @objc func dismissAction() {
        dismiss(animated: true)
    }
    
    
    func openSafari(url: URL) {
        let safariVC                        = SFSafariViewController(url: url)
        safariVC.preferredControlTintColor  = .systemGreen
        present(safariVC, animated: true)
    }
    
    
    
    
    
    func presentToastOnMainThread(message: String, ofType type: ToastType, withDuration duration: TimeInterval = 3) {
        DispatchQueue.main.async {
            
            let toastContainer = UIView(frame: .zero)
            toastContainer.alpha = 0.0
            toastContainer.layer.cornerRadius = 8;
            toastContainer.clipsToBounds  =  true
            
            switch type {
            case .success:
                toastContainer.backgroundColor = .systemGreen
            case .warning:
                toastContainer.backgroundColor = .systemYellow
            case .error:
                toastContainer.backgroundColor = .systemRed
            }
            
            let toastLabel = UILabel(frame: CGRect())
            toastLabel.textColor = UIColor.white
            toastLabel.textAlignment = .center;
            toastLabel.font = UIFont.boldSystemFont(ofSize: 16)
            toastLabel.text = message
            toastLabel.clipsToBounds  =  true
            toastLabel.numberOfLines = 0
            
            toastContainer.addSubview(toastLabel)
            self.view.addSubview(toastContainer)
            
            toastLabel.translatesAutoresizingMaskIntoConstraints = false
            toastContainer.translatesAutoresizingMaskIntoConstraints = false
            
            self.view.pin(
                toastLabel.topAnchor.constraint(equalTo: toastContainer.topAnchor),
                toastLabel.centerXAnchor.constraint(equalTo: toastContainer.centerXAnchor),
                toastLabel.bottomAnchor.constraint(equalTo: toastContainer.bottomAnchor),
                
                toastContainer.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: Padding.top),
                toastContainer.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: Padding.trailing),
                toastContainer.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor, constant: Padding.bottom),
                toastContainer.heightAnchor.constraint(equalToConstant: 50)
            )
            
            UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut, animations: {
                toastContainer.alpha = 1.0
            }, completion: { _ in
                UIView.animate(withDuration: 0.5, delay: duration, options: .curveEaseOut, animations: {
                    toastContainer.alpha = 0.0
                }, completion: {_ in
                    toastContainer.removeFromSuperview()
                })
            })
        }
    }
}


enum ToastType {
    case success, warning, error
}
