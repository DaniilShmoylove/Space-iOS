//
//  NavigationButtonStyle.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 31.07.2022.
//

import UIKit

extension UIButton.Configuration {
    public static func navigationBarMaterial() -> UIButton.Configuration {
        var style = UIButton.Configuration.plain()
        var background = UIBackgroundConfiguration.listPlainCell()
        let image = UIImage.SymbolConfiguration(pointSize: 12, weight: .semibold)
        background.cornerRadius = 21
        let backgroundEffect = UIBlurEffect(style: .light)
        background.visualEffect = backgroundEffect
        style.background = background
        style.baseForegroundColor = .label
        style.cornerStyle = .capsule
        style.preferredSymbolConfigurationForImage = image
        return style
    }
}
