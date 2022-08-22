//
//  R.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 18.08.2022.
//

import Foundation
import Resolver

//MARK: - NasaRepository protocol

protocol NasaRepository {
    func fetchPlanetaryData() async throws -> [PlanetaryModel]
}

//MARK: - NasaRepository

final class NasaRepositoryImpl: NasaRepository {
    init() { decoder = JSONDecoder() }
    
    //MARK: - ApiService
    
    @Injected private var apiService: ApiService
    
    //MARK: - JSONDecoder
    
    private var decoder: JSONDecoder
    
    //MARK: - Fetch all current coin data
    
    func fetchPlanetaryData() async throws -> [PlanetaryModel] {
        let urlRequest = try SpaceRouter.getPlanetaryData(count: AppConstants.API.feedCount).asURLRequest()
        let data = try await apiService.perform(urlRequest)
        let response = try decoder.decode([PlanetaryModel].self, from: data)
        return response
    }
}
