//
//  Localized.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 05.09.2022.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(self, comment: self)
    }
}
