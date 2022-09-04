//
//  DetailPageInteractor.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 15.08.2022.
//

import Resolver

//MARK: - DetailPage interactor protocol

protocol DetailPageInteractorLogic {
    func fetchData()
    func fetchFeedData()
}

//MARK: - DetailPage interactor class

final class DetailPageInteractor: DetailPageData {
    var presenter: DetailPagePresenterLogic?
    
    /* Planetary data */
    
    var data: PlanetaryModel?
    
    //MARK: - Nasa data service
    
    @Injected private var spaceService: SpaceService
}

//MARK: - DetailPage interactor logic

extension DetailPageInteractor: DetailPageInteractorLogic {
    
    /* Fetch feed data */

    @MainActor
    func fetchFeedData() {
        Task {
            let planetaryData = try await self.spaceService.fetchPlanetaryData()
            guard let planetaryData = planetaryData else { return }
            self.presenter?.presentFeed(data: planetaryData)
        }
    }
    
    //MARK: - Fetch data
    
    @MainActor
    func fetchData() {
        guard let data = data else { return }
        self.presenter?.present(data: data)
    }
}
