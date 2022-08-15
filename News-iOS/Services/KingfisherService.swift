//
//  KingfisherService.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 14.08.2022.
//

import Foundation
import Kingfisher

final class KingfisherService {
    init() { }
    
}

//extension KingfisherService {
//
//    //MARK: - getImage
//
//    func getImage(
//        url: URL?
//    ) {
//        if let url = url {
//            let resource = ImageResource(downloadURL: url, cacheKey: url.cacheKey)
//
//            guard ImageCache.default.isCached(forKey: url.cacheKey) else {
//
//                /* Download image if cache is empty */
//
//                self.headerView.imageView.kf
//                    .setImage(
//                        with: resource,
//                        options: [
//                            .transition(.fade(AppConstants.Duration.standart))
//                        ])
//                return
//            }
//
//            /* Load from cache */
//
//            self.headerView.imageView.kf
//                .setImage(
//                    with: resource,
//                    options: [
//                        .onlyFromCache,
//                        .transition(.fade(DrawingConstants.Duration.standart))
//                    ]) { result in
//                        switch result {
//                        case .success(let value):
//                            print("Task done for: \(value.source.url?.absoluteString ?? "")")
//                        case .failure(let error):
//                            print("Job failed: \(error.localizedDescription)")
//                        }
//                    }
//        } else {
//            //TODO: - Throw
//            print("Error url")
//        }
//    }
//
//}
