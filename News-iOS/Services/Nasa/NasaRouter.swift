//
//  NewsRouter.swift
//  News-iOS
//
//  Created by Daniil Shmoylove on 31.07.2022.
//

import Foundation
import Alamofire

enum NasaRouter {
    
    //MARK: - Router cases
    
    case getFeedNewsData
    case getSearchedData(for: String, count: String)
    
    //MARK: - Base request URL
    
    private var baseURL: URL { URL(string: "https://api.nasa.gov")! }
    
    //MARK: - Headers
    
    private var headers: HTTPHeaders { [
//        "api_key": "9xA6BUT21OeWpnFtJBRm4kFyN5cthZjMmlzWyIpv"
    ] }
    
    //MARK: - Get path
    
    private var path: String {
        switch self {
        case .getFeedNewsData:
            return "path"
        case .getSearchedData:
            return "/planetary/apod"
        }
    }
    
    //MARK: - Get HTTP method
    
    private var method: HTTPMethod {
        switch self {
        case .getFeedNewsData:
            return .get
        case .getSearchedData:
            return .get
        }
    }
    
    //MARK: - Get parameters
    
    private var parameters: Parameters {
        switch self {
        case .getFeedNewsData:
            return [:]
        case let .getSearchedData(for: request, count: count):
//            return [
//                "q": request,
//                "description": "moon%20landing",
//                "media_type": "image"
//            ]
            return [
                "count": count,
                "api_key": "9xA6BUT21OeWpnFtJBRm4kFyN5cthZjMmlzWyIpv"
            ]
//            return [:]
        }
    }
}

// MARK: - URLRequestConvertible
extension NasaRouter: URLRequestConvertible {
    internal func asURLRequest() throws -> URLRequest {
        let url = self.baseURL.appendingPathComponent(self.path)
        var request = URLRequest(url: url)
        request.method = self.method
        request.headers = self.headers
        request = try URLEncodedFormParameterEncoder(destination: .methodDependent).encode(self.parameters as? [String: String], into: request)
        print(request)
        print("###CREATE REQUEST")
        return request
    }
}
