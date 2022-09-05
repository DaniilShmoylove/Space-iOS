//
//  AppIcons.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 05.09.2022.
//

import UIKit

extension UIImage {
    
    /* App icons */
    
    enum Icons {
        
        /* Feed */
        
        static let feed: UIImage = .init(systemName: "house")!
        static let feedFill: UIImage = .init(systemName: "house.fill")!
        
        /* Favorite */
        
        static let favorite: UIImage = .init(systemName: "diamond")!
        static let favoriteFill: UIImage = .init(systemName: "diamond.fill")!
        
        /* Options */
        
        static let options: UIImage = .init(systemName: "person")!
        static let optionsFill: UIImage = .init(systemName: "person.fill")!
        
        /* Edit */
        
        static let format: UIImage = .init(systemName: "textformat.size")!
        static let add: UIImage = .init(systemName: "plus")!
        static let xmark: UIImage = .init(systemName: "xmark")!
        static let delete: UIImage = .init(systemName: "trash")!
    }
}
