//
//  SavedDataPresenter.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 22.08.2022.
//

import Foundation

//MARK: - FeedPresenter protocol

protocol SavedDataPresenterLogic: AnyObject {
    func present(data: [FeedCellModel])
}

//MARK: - FeedPresenter class

final class SavedDataPresenter {
    weak var viewController: SavedDataDisplayLogic?
}

//MARK: - FeedPresenter logic

extension SavedDataPresenter: SavedDataPresenterLogic {
    func present(data: [FeedCellModel]) {
        self.viewController?.display(data: data)
    }
}
