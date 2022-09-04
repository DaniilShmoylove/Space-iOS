//
//  HapticService.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 04.09.2022.
//

import UIKit

class HapticService {
    private init() { }
    
    //MARK: - Impact style
    
    class func impact(
        style: UIImpactFeedbackGenerator.FeedbackStyle
    ) {
        let generator = UIImpactFeedbackGenerator(style: style)
        generator.impactOccurred()
    }
    
    //MARK: - Notification style
    
    class func notification(
        type: UINotificationFeedbackGenerator.FeedbackType
    ) {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(type)
    }
    
    //MARK: - Selection style
    
    class func selection() {
        let generator = UISelectionFeedbackGenerator()
        generator.selectionChanged()
    }
}
