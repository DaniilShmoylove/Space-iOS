//
//  DrawningConstant.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 30.07.2022.
//

import UIKit

enum AppConstants {
    
    //MARK: - Paddings
    
    enum UI {
        
        /* Application layout & constants */
        
        static let horizontal: CGFloat = 28
        static let vertical: CGFloat = 16
        static let verticalDefault: CGFloat = 6
        static let cellVertical: CGFloat = 10
        static let padding: CGFloat = 16
        static let lowPadding: CGFloat = 12
        static let headerHeight: CGFloat = 42
        static let exploreHeight: CGFloat = 72
        static let materialButton: CGRect = CGRect(x: 0, y: 0, width: 36, height: 36)
        static let cornerRadius: CGFloat = 16
        static let sheetCornerRadius: CGFloat = 24
        static let multipliedBy: CGFloat = 0.5625
    }
    
    //MARK: - Core
    
    enum Core {
        
        /* 128 MB cache size */
        
        static let cacheSize: UInt = 1024 * 1024 * 128
        
        /* 0.45 sec standart duration */
        
        static let standartDuration: CGFloat = 0.45
    }
    
    enum API {
        static let feedCount: String = "10"
    }
}

extension UIFont {
    static let largeTitle: UIFont = .systemFont(ofSize: 36, weight: .black)
}

