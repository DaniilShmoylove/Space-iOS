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
        
        if let predicate = planetaryModel.url {
            
            /* Filter by id */
         
            request.predicate = NSPredicate(format: "url == %@", predicate)
        }
        
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
        planetaryEntity.image = planetaryModel.image
        
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
    
    //MARK: - Is added
    
    /* checks for the presence of an element in the collection */
    
    @discardableResult
    class func checkDuplicate(
        for planetaryModel: PlanetaryModel,
        _ context: NSManagedObjectContext
    ) throws -> Bool {
        let request: NSFetchRequest<PlanetaryEntity> = PlanetaryEntity.fetchRequest()
        
        if let predicate = planetaryModel.url {
            
            /* Filter by id */
         
            request.predicate = NSPredicate(format: "url == %@", predicate)
        }
        
        /* Check duplicate */
        
        do {
            let fetchResult = try context.fetch(request)
            guard fetchResult.count > 0 else { return false }
            return true
        } catch {
            throw error
        }
    }
}
