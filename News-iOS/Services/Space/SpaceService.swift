//
//  SpaceService.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 10.08.2022.
//

import Alamofire
import Resolver

//MARK: - SpaceService protocol

protocol SpaceService {
    func fetchPlanetaryData() async throws -> [PlanetaryModel]?
}

//MARK: - SpaceService class

final class NasaServiceImpl: SpaceService {
    init() { }
    
    //MARK: - NasaRepository
    
    @Injected private var nasaRepository: NasaRepository
    
    //MARK: - Fetch planetary data
    
    @MainActor
    func fetchPlanetaryData() async throws -> [PlanetaryModel]? {
        let data = try await self.nasaRepository.fetchPlanetaryData()
        return data
    }
}
