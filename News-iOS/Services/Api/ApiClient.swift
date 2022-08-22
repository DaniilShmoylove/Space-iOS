//
//  ApiClient.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 18.08.2022.
//

import Foundation
import Alamofire
import Combine

//MARK: - ApiService protocol

public protocol ApiService {
    func perform(_ urlRequest: URLRequest) -> AnyPublisher<Data, Error>
    @discardableResult func perform(_ urlRequest: URLRequest) async throws -> Data
    var interceptor: RequestInterceptor? { get set }
}

//MARK: - ApiService

public class ApiServiceImpl: ApiService {
    public init() { }
    
    public var interceptor: RequestInterceptor?
    
    //MARK: - Perform any publisher
    
    public func perform(_ urlRequest: URLRequest) -> AnyPublisher<Data, Error> {
        AF.request(urlRequest, interceptor: interceptor)
            .validate(statusCode: 200..<300)
            .publishData(emptyResponseCodes: [200, 204, 205])
            .value()
            .mapError({$0 as Error})
            .eraseToAnyPublisher()
    }
    
    //MARK: - Perform data
    
    public func perform(_ urlRequest: URLRequest) async throws -> Data {
        let data = try await AF.request(urlRequest, interceptor: interceptor)
            .validate(statusCode: 200..<300)
            .serializingData(emptyResponseCodes: [200, 204, 205])
            .value
        return data
    }
}
