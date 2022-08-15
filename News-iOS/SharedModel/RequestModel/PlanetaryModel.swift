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
    let copyright, date, explanation: String?
    let hdurl: String?
    let mediaType, serviceVersion, title: String?
    let url: String?
    
    var imageURL: URL? {
        guard let url = hdurl else { return nil }
        return URL(string: url)
    }
    
    /* Cached image view */
    
//    lazy let imageView: UIImageView = {
//        let imageView = UIImageView()
//        guard let url = imageURL else { return UIImageView() }
//        let resource = ImageResource(downloadURL: url, cacheKey: url.cacheKey)
//        imageView.kf.indicatorType = .activity
//        imageView.kf
//            .setImage(
//                with: resource,
//                options: [
//                    .loadDiskFileSynchronously,
//                    .cacheOriginalImage,
//                    .transition(.fade(0.35))
//                ])
//
//        return imageView
//    }()
    
    var info: String {
        return (copyright?.count ?? 0 > 0 ? "\(copyright ?? ""), \(date ?? "")" : date ?? "")
    }

    enum CodingKeys: String, CodingKey {
        case copyright, date, explanation, hdurl
        case mediaType = "media_type"
        case serviceVersion = "service_version"
        case title, url
    }
}
