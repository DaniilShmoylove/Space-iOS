//
//  FeedInteractor.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 14.08.2022.
//

import Foundation
import Alamofire

protocol FeedInteractorLogic {
    func fetchData()
}

final class FeedInteractor {
    var presenter: FeedPresenterLogic?
    
    //MARK: - Feed data
    
    private(set) var data: [FeedCellModel] = []
}

//MARK: - Interactor logic  

extension FeedInteractor: FeedInteractorLogic {
    
    //MARK: - Fetch current planetary data
    
    func fetchPlanetaryData(
        completion: @escaping ([PlanetaryModel]) -> ()
    ) {
        AF.request(
            NasaRouter.getSearchedData(
                for: "apollo%2011",
                count: "2"
            )
        )
        .validate()
        .responseDecodable(
            of: [PlanetaryModel].self
        ) { [weak self] (response) in
            guard
                let self = self,
                let planetaryData = response.value
            else { return }
            completion(planetaryData)
        }
    }
    
    @MainActor
    func fetchData() {
        self.fetchPlanetaryData { data in
            self.data.append(.pictureOfTheDay(data))
            self.presenter?.present(data: self.data)
        }
    }
    
}
