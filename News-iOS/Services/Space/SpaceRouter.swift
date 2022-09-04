//
//  NewsRouter.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 31.07.2022.
//

import Foundation
import Alamofire

enum SpaceRouter {
    
    //MARK: - Router cases
    
    case getPlanetaryData(count: String)
    
    //MARK: - Base request URL
    
    private var baseURL: URL { URL(string: "https://api.nasa.gov")! }
    
    //MARK: - Headers
    
    private var headers: HTTPHeaders { [
        "api_key": "9xA6BUT21OeWpnFtJBRm4kFyN5cthZjMmlzWyIpv"
    ] }
    
    //MARK: - Get path
    
    private var path: String {
        switch self {
        case .getPlanetaryData:
            return "/planetary/apod"
        }
    }
    
    //MARK: - Get HTTP method
    
    private var method: HTTPMethod {
        switch self {
        case .getPlanetaryData:
            return .get
        }
    }
    
    //MARK: - Get parameters
    
    private var parameters: Parameters {
        switch self {
        case let .getPlanetaryData(count: count):
            return [
                "count": count,
                "api_key": "9xA6BUT21OeWpnFtJBRm4kFyN5cthZjMmlzWyIpv"
            ]
        }
    }
}

// MARK: - URLRequestConvertible

extension SpaceRouter: URLRequestConvertible {
    internal func asURLRequest() throws -> URLRequest {
        let url = self.baseURL.appendingPathComponent(self.path)
        var request = URLRequest(url: url)
        request.method = self.method
        request.headers = self.headers
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(self.parameters as? [String: String], into: request)
        return request
    }
}
