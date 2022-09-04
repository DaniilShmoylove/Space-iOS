//
//  FeedPresenter.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 14.08.2022.
//

import Foundation

//MARK: - FeedPresenter protocol

protocol FeedPresenterLogic: AnyObject {
    func present(data: [FeedCellModel])
}

//MARK: - FeedPresenter class

final class FeedPresenter {
    weak var viewController: FeedDisplayLogic?
}

//MARK: - FeedPresenter logic

extension FeedPresenter: FeedPresenterLogic {
    func present(data: [FeedCellModel]) {
        self.viewController?.display(data: data)
    }
}


