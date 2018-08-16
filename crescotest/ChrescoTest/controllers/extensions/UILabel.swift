//
//  UILabel.swift
//  ChrescoTest
//
//  Created by miguel on 8/15/18.
//  Copyright © 2018 Samtech. All rights reserved.
//

import Foundation
import UIKit

extension UILabel{
    
    func textDropShadow() {
        self.layer.masksToBounds = false
        self.layer.shadowRadius = 2.0
        self.layer.shadowOpacity = 0.5
        self.layer.shadowOffset = CGSize(width: 1, height: 2)
    }
    
    static func createCustomLabel() -> UILabel {
        let label = UILabel()
        label.textDropShadow()
        return label
    }
}
