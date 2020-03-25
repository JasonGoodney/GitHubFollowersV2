//
//  CALayer+Ext.swift
//  GithubFollowersV2
//
//  Created by Jason Goodney on 3/24/20.
//  Copyright © 2020 Jason Goodney. All rights reserved.
//

import UIKit

extension CALayer {
    
    func animateBorderColor(from startColor: UIColor, to endColor: UIColor, withDuration duration: Double, delay: TimeInterval = 0, completion: ((Bool) -> Void)? = nil) {
        
        DispatchQueue.main.asyncAfter(deadline: .now() + delay) {
            let colorAnimation = CABasicAnimation(keyPath: "borderColor")
            colorAnimation.fromValue = startColor.cgColor
            colorAnimation.toValue = endColor.cgColor
            colorAnimation.duration = duration
            self.borderColor = endColor.cgColor
            self.add(colorAnimation, forKey: "borderColor")
            
            if let completion = completion {
                completion(true)
            }
        }
    }
}
