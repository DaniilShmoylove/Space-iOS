//
//  FeedInteractor.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 14.08.2022.
//

import Resolver

//MARK: - Feed interactor protocol

protocol FeedInteractorLogic {
    func fetchData() async throws
    func loadMore()
}

//MARK: - Feed interactor class

final class FeedInteractor {
    init() { }
    
    //MARK: - Presenter
    
    var presenter: FeedPresenterLogic?
    
    //MARK: - Space service
    
    @Injected private var spaceService: SpaceService
    
    //MARK: - Planetary data
    
    var planetaryData = [PlanetaryModel]()
}

//MARK: - Interactor logic  

extension FeedInteractor: FeedInteractorLogic {
    
    //MARK: - Fetch data
    
    @MainActor
    func fetchData() async {
        do {
            
            /* Fetch current planetary data */
            
            let planetaryData = try await self.spaceService.fetchPlanetaryData()
            guard let planetaryData = planetaryData else { return }
            self.planetaryData = planetaryData
            
            /* FeedCell data */
            
            var data = [FeedCellModel]()
            data.append(.pictureOfTheDay(self.planetaryData))
            self.presenter?.present(data: data)
        } catch {
            print(error.localizedDescription)
        }
    }
    
    /* Fetch and append data */
    
    @MainActor
    func loadMore() {
        Task {
            
            /* Get planetary data */
            
            let planetaryData = try await self.spaceService.fetchPlanetaryData()
            guard let planetaryData = planetaryData else { return }
            self.planetaryData += planetaryData
            
            /* FeedCell data */
            
            var data = [FeedCellModel]()
            data.append(.pictureOfTheDay(self.planetaryData))
            self.presenter?.present(data: data)
        }
    }
}
