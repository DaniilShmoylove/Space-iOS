//
//  DataService.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 02.08.2022.
//

import CoreData

final class DataService {
    private init() { }
    
    //MARK: - Singleton
    
    static let shared: DataService = DataService()
}

extension DataService {
    
    //MARK: - Get all data
    
    @MainActor
    func getData() async throws -> [PlanetaryModel]? {
        AppDelegate.container.viewContext.performAndWait {
            let data = try? PlanetaryEntity.fetchAllEntity(AppDelegate.container.viewContext)
            let newsData = data?.map { PlanetaryModel(entity: $0) }
            guard let newsData = newsData else { return nil }
            return newsData
        }
    }
    
    //MARK: - Save data
    
    @MainActor
    func saveData(
        for models: PlanetaryModel
    ) {
        AppDelegate.container.viewContext.perform {
            do {
                try PlanetaryEntity.fetchEntity(
                    for: models,
                    AppDelegate.container.viewContext
                )
                AppDelegate.saveContext()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
    
    //MARK: - Check duplicate
    
    @MainActor
    func checkDuplicate(
        for planetaryModel: PlanetaryModel
    ) -> Bool {
        do {
            return try PlanetaryEntity.checkDuplicate(
                for: planetaryModel,
                AppDelegate.container.viewContext
            )
        } catch {
            print(error.localizedDescription)
        }
        return false
    }
    
    //MARK: - Delete all data
    
    func deleteAll() {
        do {
            let newsEntities = try PlanetaryEntity.fetchAllEntity(AppDelegate.container.viewContext)
            for newsEntity in newsEntities { AppDelegate.container.viewContext.delete(newsEntity) }
            AppDelegate.saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
    
    //MARK: - Delete item 
    
    @MainActor
    func deleteItem(
        for planetaryModel: PlanetaryModel
    ) {
        do {
            let planetaryEntity = try PlanetaryEntity.fetchEntity(for: planetaryModel, AppDelegate.container.viewContext)
            AppDelegate.container.viewContext.delete(planetaryEntity)
            AppDelegate.saveContext()
        } catch {
            print(error.localizedDescription)
        }
    }
}
