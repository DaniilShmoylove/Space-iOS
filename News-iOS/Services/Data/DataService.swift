//
//  DataService.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 02.08.2022.
//

import Foundation
import UIKit
import CoreData

final class DataService {
    private init() { }
    
    //MARK: - Singleton
    
    static let shared: DataService = DataService()
}

extension DataService {
    
    //MARK: - Get all data
    
    func getAllData(
        _ completion: @escaping ([NewsModel]) -> Void
    ) {
        AppDelegate.container.viewContext.perform {
            let newsEntities = try? NewsEntity.fetchAllEntity(AppDelegate.container.viewContext)
            let newsData = newsEntities?.map { NewsModel(entity: $0) }
            completion(newsData ?? [])
        }
    }
    
    //MARK: - Save data
    
    func saveData(
        for models: [NewsModel]
    ) throws {
        AppDelegate.container.viewContext.perform {
            let _ = try? models.compactMap { try NewsEntity.fetchEntity(for: $0, AppDelegate.container.viewContext) }
            AppDelegate.saveContext()
        }
    }
    
    //MARK: - Delete all data
    
    func deleteAll() {
        do {
            let newsEntities = try NewsEntity.fetchAllEntity(AppDelegate.container.viewContext)
            for newsEntity in newsEntities { AppDelegate.container.viewContext.delete(newsEntity) }
            AppDelegate.saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
}
