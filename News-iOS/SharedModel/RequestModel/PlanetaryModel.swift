//
//  PlanetaryModel.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 12.08.2022.
//

import Foundation
import UIKit
import Kingfisher

// MARK: - PlanetaryModel

struct PlanetaryModel: Codable {
    
    init(
        entity: PlanetaryEntity
    ) {
        self.copyright = entity.copyright
        self.date = entity.date
        self.explanation = entity.explanation
        self.hdurl = entity.hdurl
        self.mediaType = entity.mediaType
        self.serviceVersion = entity.serviceVersion
        self.title = entity.title
        self.url = entity.url
    }
    
    let copyright, date, explanation: String?
    let hdurl: String?
    let mediaType, serviceVersion, title: String?
    let url: String?
    
    let cellType: PlanetaryCellType = { PlanetaryCellType.allCases.randomElement()! }()
    
    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}

extension PlanetaryModel {
    var imageURL: URL? {
        guard let url = hdurl else { return nil }
        return URL(string: url)
    }
    
    var copyrightWithDate: String {
        return (copyright != nil  ? "\(copyright ?? ""), \(date ?? "")" : date ?? "")
    }
    
    var copyrightWithPointDate: String {
        return (copyright != nil  ? "\(copyright ?? "") · \(date ?? "")" : date ?? "")
    }
    
    var titleWithDate: String {
        return (title != nil ? "\(title ?? ""), \(date ?? "")" : date ?? "")
    }
}