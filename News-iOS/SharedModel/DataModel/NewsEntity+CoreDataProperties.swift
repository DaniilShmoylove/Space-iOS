//
//  NewsEntity+CoreDataProperties.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 03.08.2022.
//
//

import Foundation
import CoreData

extension NewsEntity {
    
    //MARK: - Fetch request 
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<NewsEntity> {
        return NSFetchRequest<NewsEntity>(entityName: "NewsEntity")
    }
    
    //MARK: - Properties
    
    @NSManaged public var id: String?
    @NSManaged public var title: String?
    @NSManaged public var image: Data?
}

extension NewsEntity : Identifiable { }
