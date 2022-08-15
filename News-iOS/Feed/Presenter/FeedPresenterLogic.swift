//
//  FeedPresenter.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 14.08.2022.
//

import Foundation

protocol FeedPresenterLogic: AnyObject {
    func present(data: [FeedCellModel])
}

final class FeedPresenter {
    weak var viewController: FeedViewControllerLogic?
}

//MARK: - Presenter logic

extension FeedPresenter: FeedPresenterLogic {
    func present(data: [FeedCellModel]) {
        self.viewController?.display(data: data)
    }
}


