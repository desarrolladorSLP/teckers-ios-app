//
//  SessionRouter.swift
//  teckers
//
//  Created by Ricardo Granja on 9/13/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import Alamofire

enum SessionRouter: URLRequestConvertible {
    case getSessions(year: Int, month: Int)
    case setSessionAssistance(id: String)
    var method: HTTPMethod {
        switch self {
        case .getSessions:
            return .get
        case .setSessionAssistance(_):
            return .post
        }
        
    }
    
    var parameters: Parameters? {
        switch self {
        case .getSessions(_, _):
            return nil
        case .setSessionAssistance(_):
            return nil
        }
    }
    
    var path: String {
        switch self {
        case .getSessions(let year, let month):
            return "api/events/\(year)/\(month)"
        case .setSessionAssistance(let id):
            return "/api/session/confirm/\(id)"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try RoadURL.baseURL.rawValue.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        let tokendictionary = Token()
        
        urlRequest.httpMethod = method.rawValue
        if let accessToken = try tokendictionary.getToken(user: TokenKeys.AccessToken.rawValue) {
            urlRequest.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
        }
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
