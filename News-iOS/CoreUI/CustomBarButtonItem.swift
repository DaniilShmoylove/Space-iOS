//
//  CustomBarButtonItem.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 31.08.2022.
//

import UIKit

extension UIBarButtonItem {
    
    /* Create Navigation button view */
    
    static func createBarButtonItem(
        iconString: String,
        target: Any?,
        action: Selector?
    ) -> UIBarButtonItem {
        let configuration = UIButton.Configuration.navigationBarMaterial()
        let button = UIButton(configuration: configuration)
        button.frame = AppConstants.UI.materialButton
        if let action = action { button.addTarget(target, action: action, for: .touchUpInside) }
        button.setImage(UIImage(systemName: iconString), for: .normal)
        return UIBarButtonItem(customView: button)
    }
}
