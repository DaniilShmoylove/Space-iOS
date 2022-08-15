//
//  FeedManager.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 31.07.2022.
//

import Foundation
import Alamofire

enum FeedManagerError {
    case badResponse(URLResponse)
}

final class FeedManager {
    init() { }
    
    //MARK: - Feed data
    
    private(set) var data: [FeedCellModel] = []
    
    //TODO: - Pagefeed data
    
//    private(set) var pagefeedData = [PlanetaryModel]()
    
    //MARK: - Data service
    
    private var dataService = DataService.shared
}

extension FeedManager {
    
    //MARK: - Fetch current planetary data 
    
    func fetchPlanetaryData(
        completion: @escaping () -> ()
    ) {
        AF.request(
            NasaRouter.getSearchedData(
                for: "apollo%2011",
                count: "8"
            )
        )
        .validate()
        .responseDecodable(of: [PlanetaryModel].self) { [weak self] (response) in
            guard let planetaryData = response.value else { return }
            guard let self = self else { return }
            self.data.append(.pictureOfTheDay(planetaryData))
            completion()
        }
    }
    
    //MARK: - Get news data
    
    private func getAllNews(
        _ completion: @escaping ([NewsModel]) -> Void
    ) {
        self.dataService.getAllData { data in
            print(data)
            if data.isEmpty {
                /* if data is empty then fetch data */
                do {
                    try self.dataService.saveData(
                        for: []
                    )
                } catch {
                    print(error)
                }
            } else {
                self.data.append(.news(data))
                completion(data)
            }
        }
    }
    
    //MARK: - Save news data
    
    private func saveNews(
        _ completion: @escaping () -> ()
    ) {
        do {
            try self.dataService.saveData(for: [.init(id: "", title: "mock", image: nil)])
        } catch {
            print(error)
        }
        
        self.getAllNews { data in
            self.data = [.news(data)]
            completion()
        }
    }
    
    //MARK: - Update data
    
    private func updateData() {
        
    }
    
    func deleteAll() {
        self.dataService.deleteAll()
        self.data.removeAll()
    }
    
    //MARK: - Mock
    
//    private func mock() {
//        self.data.append(
//            .explore(
//                [
//                    .init(name: "Philosophy"),
//                    .init(name: "Sport"),
//                    .init(name: "Inv estemnt"),
//                    .init(name: "Crypto"),
//                    .init(name: "Sport"),
//                    .init(name: "Inv estemnt"),
//                    .init(name: "Crypto"),
//                    .init(name: "Sport"),
//                    .init(name: "Inv estemnt")
//                ]
//            )
//        )
//
//        self.data.append(
//            .news(
//                [
//                    .init(id: "", title: "mock", image: nil),
//                    .init(id: "", title: "mock", image: nil),
//                    .init(id: "", title: "mock", image: nil)
//                ]
//            )
//        )
//    }
}

//MARK: - FeedCeelModel

enum FeedCellModel {
    case pictureOfTheDay(_ items: [PlanetaryModel])
    case explore(_ items: [ExploreModel])
    case news(_ items: [NewsModel])
}
