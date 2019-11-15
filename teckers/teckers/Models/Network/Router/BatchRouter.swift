//
//  BatchRouter.swift
//  teckers
//
//  Created by Maggie Mendez on 15/11/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import Alamofire

enum BatchRouter: URLRequestConvertible {
    
    case getBatches( programId: String)
    
    var method: HTTPMethod {
        switch self {
            case .getBatches(_):
                return .get
        }
    }
    
    var path: String {
        switch self {
            case .getBatches(let id):
                return "/api/batch/program/\(id)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try RoadURL.baseURL.rawValue.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        let tokendictionary = Token()
        if let accessToken = try tokendictionary.getToken(user: TokenKeys.AccessToken.rawValue){
            urlRequest.setValue("\(Header.Bearer.rawValue) \(accessToken)", forHTTPHeaderField: Header.Authorization.rawValue)
        }
        return try URLEncoding.default.encode(urlRequest, with: nil)
    }
}
