//
//  UITextField.swift
//  ChrescoTest
//
//  Created by miguel on 8/15/18.
//  Copyright © 2018 Samtech. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    
    func shake() {
        let animation = CABasicAnimation(keyPath: "position")
        animation.duration = 0.05
        animation.repeatCount = 5
        animation.autoreverses = true
        animation.fromValue = CGPoint(x: self.center.x - 4.0, y: self.center.y)
        animation.toValue = CGPoint(x: self.center.x + 4.0, y: self.center.y)
        layer.add(animation, forKey: "position")
    }
    
}
