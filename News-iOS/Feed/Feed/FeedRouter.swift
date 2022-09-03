//
//  SpaceRouter.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 15.08.2022.
//

import UIKit

//MARK: - FeedRouter protocol

protocol FeedRouterLogic {
    func routeToDetailPage(data: PlanetaryModel)
}

//MARK: - FeedRouter class

final class FeedRouter {
    weak var viewController: UIViewController?
}

//MARK: - FeedRouter logic

extension FeedRouter: FeedRouterLogic {
    
    //MARK: - Routing
    
    /* Route to detail page vc */
    
    func routeToDetailPage(data: PlanetaryModel) {
        let destination = DetailPageViewController()
        destination.router?.dataStore?.data = data
        self.viewController?
            .navigationController?
            .pushViewController(destination, animated: true)
    }
}
