//
//  File.swift
//  Marvel
//
//  Created by Rabi Chourasia on 10/03/22.
//

import Foundation
import UIKit

extension UIView {
    
    func cardViewShadow() {
        self.layer.cornerRadius = 8
        self.layer.shadowColor = UIColor.init(red: 11.0/255.0, green: 17.0/255.0, blue: 52.0/255.0, alpha: 0.15).cgColor
        self.layer.shadowOffset = CGSize(width: 0.0, height: 0.0)
        self.layer.shadowRadius = 4.0
        self.layer.shadowOpacity = 1.0
    }
    
}
