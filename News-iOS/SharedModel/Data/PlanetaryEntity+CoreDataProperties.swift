//
//  PlanetaryEntity+CoreDataProperties.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 03.08.2022.
//
//

import Foundation
import CoreData

extension PlanetaryEntity {
    
    //MARK: - Fetch request
    
    @nonobjc public class func fetchRequest() -> NSFetchRequest<PlanetaryEntity> {
        return NSFetchRequest<PlanetaryEntity>(entityName: "PlanetaryEntity")
    }
    
    //MARK: - Properties
    
    @NSManaged public var copyright: String?
    @NSManaged public var date: String?
    @NSManaged public var explanation: String?
    @NSManaged public var hdurl: String?
    @NSManaged public var mediaType: String?
    @NSManaged public var serviceVersion: String?
    @NSManaged public var title: String?
    @NSManaged public var url: String?
    @NSManaged public var image: Data?
}

extension PlanetaryEntity: Identifiable { }
