//
//  NasaRouter.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 15.08.2022.
//

import Foundation
import UIKit

protocol FeedRouterLogic: AnyObject {
    func navigationToDetailPage(data: PlanetaryModel)
}

final class FeedRouter {
    weak var viewController: UIViewController?
}

extension FeedRouter: FeedRouterLogic {
    func navigationToDetailPage(data: PlanetaryModel) {
        print("### - \(data)")
        let destination = DetailPageViewController()
        destination.router?.store?.data = data
        self.viewController?
            .navigationController?
            .pushViewController(destination, animated: true)
    }
    
    
}
