//
//  NasaService.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 10.08.2022.
//

import Alamofire
import UIKit

//MARK: - NasaService protocol

protocol NasaService {
    //    func fetchAllCurrentMetaData() async throws -> [Coin]?
    //    func fetchCoinData(for uuid: String) async throws -> CoinDetail?
}

final class NasaServiceImpl: NasaService {
    init() { }
    
}

extension NasaServiceImpl {
    
    func getSearchedData(for: String) {
//        AF.request(NasaRouter.getSearchedData(for: ""))
//            .validate()
//            .responseDecodable(of: NasaRouter.self) { (response) in
////                guard let monsters = response.value else { return }
////                self.monsters = monsters.all
////                self.tableView.reloadData()
//            }
    }
    
}


protocol NasaRepository {
    
}

final class NasaRepositoryImpl: NasaRepository {
    init() { }
}

