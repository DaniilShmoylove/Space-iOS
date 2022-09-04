//
//  SavedDataInteractor.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 22.08.2022.
//

import Foundation

//MARK: - SavedData interactor protocol

protocol SavedDataInteractorLogic {
    func fetchData() async throws
}

//MARK: - SavedData interactor class

final class SavedDataInteractor {
    init() { }
    
    //MARK: - Presenter
    
    var presenter: SavedDataPresenterLogic?
    
    //MARK: - Data service
    
    private var dataService = DataService.shared
}

//MARK: - SavedData interactor logic

extension SavedDataInteractor: SavedDataInteractorLogic {
    
    //MARK: - Fetch data
    
    @MainActor
    func fetchData() async {
        do {
            let savedPlanetaryData = try await self.dataService.getData()
            guard let savedPlanetaryData = savedPlanetaryData else { return }
            
            var feedCellModel = [FeedCellModel]()
            feedCellModel.append(.pictureOfTheDay(savedPlanetaryData))
            self.presenter?.present(data: feedCellModel)
        } catch {
            print(error.localizedDescription)
        }
    }
}
