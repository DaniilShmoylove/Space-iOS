//
//  PlanetaryEntity.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 02.08.2022.
//

import Foundation
import CoreData

//MARK: - PlanetaryEntity

@objc(PlanetaryEntity)
final class PlanetaryEntity: NSManagedObject {
    
    //MARK: - Create entities
    
    @discardableResult
    class func fetchEntity(
        for planetaryModel: PlanetaryModel,
        _ context: NSManagedObjectContext
    ) throws -> PlanetaryEntity {
        let request: NSFetchRequest<PlanetaryEntity> = PlanetaryEntity.fetchRequest()
        
        /* Filter by id */
        
        request.predicate = NSPredicate(format: "url == %@", planetaryModel.url!)
        
        /* Check duplicate */
        
        do {
            let fetchResult = try context.fetch(request)
            if fetchResult.count > 0 {
                assert(fetchResult.count == 1, "Duplicate has been found")
                return fetchResult[0]
            }
        } catch {
            throw error
        }
        
        let planetaryEntity = PlanetaryEntity(context: context)
        
        /* Fill */
        
        planetaryEntity.copyright = planetaryModel.copyright
        planetaryEntity.date = planetaryModel.date
        planetaryEntity.explanation = planetaryModel.explanation
        planetaryEntity.hdurl = planetaryModel.hdurl
        planetaryEntity.mediaType = planetaryModel.mediaType
        planetaryEntity.serviceVersion = planetaryModel.serviceVersion
        planetaryEntity.title = planetaryModel.title
        planetaryEntity.url = planetaryModel.url
        
        return planetaryEntity
    }
    
    //MARK: - Get all entities
    
    class func fetchAllEntity(
        _ context: NSManagedObjectContext
    ) throws -> [PlanetaryEntity] {
        let request: NSFetchRequest<PlanetaryEntity> = PlanetaryEntity.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            throw error
        }
    }
}

