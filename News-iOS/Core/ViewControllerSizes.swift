//
//  ViewControllerSizes.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 05.08.2022.
//

import UIKit

extension UIViewController {

    //MARK: - NavigationBar height 
    
    var topbarHeight: CGFloat {
        return (view.window?.windowScene?.statusBarManager?.statusBarFrame.height ?? 0.0) +
            (self.navigationController?.navigationBar.frame.height ?? 0.0)
    }
}
