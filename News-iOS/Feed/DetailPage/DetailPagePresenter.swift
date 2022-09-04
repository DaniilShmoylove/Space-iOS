//
//  DetailPagePresenter.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 15.08.2022.
//

import Foundation

//MARK: - DetailPage presenter protocol

protocol DetailPagePresenterLogic {
    func present(data: PlanetaryModel)
    func presentFeed(data: [PlanetaryModel])
}

//MARK: - DetailPage presenter class

final class DetailPagePresenter {
    weak var viewController: DetailPageDisplayLogic?
}

//MARK: - DetailPage presenter logic

extension DetailPagePresenter: DetailPagePresenterLogic {
    func present(data: PlanetaryModel) {
        self.viewController?.display(data: data)
    }
    
    func presentFeed(data: [PlanetaryModel]) {
        self.viewController?.displayFeed(data: data)
    }
}
