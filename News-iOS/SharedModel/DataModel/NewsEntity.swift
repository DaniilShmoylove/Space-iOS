//
//  NewsEntity.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 02.08.2022.
//

import Foundation
import CoreData

//MARK: - NewsEntity

@objc(NewsEntity)
final class NewsEntity: NSManagedObject {
    
    //MARK: - Create entities
    
    class func fetchEntity(
        for news: NewsModel,
        _ context: NSManagedObjectContext
    ) throws -> NewsEntity {
        let request: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        
        /* Filter by id */
        
        request.predicate = NSPredicate(format: "id == %d", news.id)
        
        /* Check duplicate */
        
        do {
            let fetchResult = try context.fetch(request)
            if let first = fetchResult.first {
                assert(!fetchResult.isEmpty, "Duplicate has been found")
                return first
            }
        } catch {
            throw error
        }
        
        let newsEntity = NewsEntity(context: context)
        
        /* Fill */
        
        newsEntity.id = news.id
        newsEntity.title = news.title
        newsEntity.image = news.image
        
        return newsEntity
    }
    
    //MARK: - Get all entities
    
    class func fetchAllEntity(
        _ context: NSManagedObjectContext
    ) throws -> [NewsEntity] {
        let request: NSFetchRequest<NewsEntity> = NewsEntity.fetchRequest()
        
        do {
            return try context.fetch(request)
        } catch {
            throw error
        }
    }
}

