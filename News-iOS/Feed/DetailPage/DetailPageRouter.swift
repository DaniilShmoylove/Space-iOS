//
//  DetailPageRouter.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 15.08.2022.
//

import Foundation

//MARK: - DetailPage router protocol

protocol DetailPageRouterLogic { }

//MARK: - DetailPage router class

final class DetailPageRouter: DetailPageStorePass {
    weak var store: DetailPageData?
}

//MARK: - DetailPage router logic

extension DetailPageRouter: DetailPageRouterLogic { }

//MARK: - DetailPage router pass

protocol DetailPageStorePass {
    var store: DetailPageData? { get }
}

//MARK: - DetailPage router data

protocol DetailPageData: AnyObject {
    var data: PlanetaryModel? { get set }
}
