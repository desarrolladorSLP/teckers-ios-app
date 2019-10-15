//
//  MessagesRouter.swift
//  
//
//  Created by Maggie Mendez on 9/12/19.
//

import Foundation
import Alamofire

enum MessagesRouter: URLRequestConvertible {
    
    case getMessages
    
    var method: HTTPMethod {
        switch self {
        case .getMessages:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        var parameters: [String: Any] = [:]
        switch self {
        case .getMessages:
            parameters = [:]
        }
        return parameters
    }
    
    var path: String {
        switch self {
        case .getMessages:
            return "/api/message"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try RoadURL.baseURL.rawValue.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        let tokendictionary = Token()
        if let accessToken = try tokendictionary.getToken(user: TokenKeys.AccessToken.rawValue){
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}

