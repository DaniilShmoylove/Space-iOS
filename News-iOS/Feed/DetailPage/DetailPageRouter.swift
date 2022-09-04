//
//  DetailPageRouter.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 15.08.2022.
//

import UIKit

//MARK: - DetailPage router protocol

protocol DetailPageRouterLogic {
    func routeToDetaiPage(data: PlanetaryModel)
}

//MARK: - DetailPage router class

final class DetailPageRouter: DetailPageDataPassing {
    weak var viewController: UIViewController?
    weak var dataStore: DetailPageData?
}

//MARK: - DetailPage router logic

extension DetailPageRouter: DetailPageRouterLogic {
    func routeToDetaiPage(data: PlanetaryModel) {
        let destination = DetailPageViewController()
        destination.router?.dataStore?.data = data
        self.viewController?
            .navigationController?
            .pushViewController(destination, animated: true)
    }
}

//MARK: - DetailPage router pass

protocol DetailPageDataPassing { var dataStore: DetailPageData? { get } }

//MARK: - DetailPage router data

protocol DetailPageData: AnyObject { var data: PlanetaryModel? { get set } }
