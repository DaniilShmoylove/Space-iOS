//
//  AppResolver.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 02.08.2022.
//

import Resolver

extension Resolver: ResolverRegistering {
    
    //MARK: - Register all services
    
    public static func registerAllServices() {
        
        //MARK: - ApiService
        
        register { ApiServiceImpl() }
            .implements(ApiService.self)
        
        //MARK: - SpaceService
        
        register { NasaServiceImpl() }
            .implements(SpaceService.self)
        
        //MARK: - SpaceRepository
        
        register { SpaceRepositoryImpl() }
            .implements(SpaceRepository.self)
        
        //MARK: - AuthenticationService
        
        register { AuthenticationServiceImpl() }
            .implements(AuthenticationService.self)
    }
}
