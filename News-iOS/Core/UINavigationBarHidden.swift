//
//  UINavigationBarHidden.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 04.08.2022.
//

import UIKit

extension UINavigationController {
    
    open func setNavigationItemBackground(hidden: Bool) {
        guard hidden else {
//            self.navigationBar = UINavigationBar()
            return
        }
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = .clear
    }
    
    open func setNavigationItemBackground(color: UIColor) {
        self.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationBar.shadowImage = UIImage()
        self.navigationBar.isTranslucent = true
        self.view.backgroundColor = color
    }
}
