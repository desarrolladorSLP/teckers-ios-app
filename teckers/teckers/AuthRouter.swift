//
//  AuthRouter.swift
//  teckers
//
//  Created by Ricardo Granja on 8/5/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import Alamofire

enum AuthRouter: URLRequestConvertible {
    case auth(token: String)
    
    static let baseURLString = "https://teckers-backend.herokuapp.com"
    
    var method: HTTPMethod {
        switch self {
        case .auth:
            return .post
        }
    }
    
    var parameters: [String: Any] {
        var parameters: [String: Any] = [:]
        switch self {
        case .auth(let token):
            parameters = ["grant_type": "firebase", "firebase-token-id": token]
        }
        
        return parameters
    }
    
    var path: String {
        switch self {
        case .auth:
            return "/oauth/token"
        }
    }
     
    func asURLRequest() throws -> URLRequest {
        let url = try AuthRouter.baseURLString.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        urlRequest.httpMethod = method.rawValue
        
        urlRequest.setValue("Basic dGVjaG5vdmF0aW9uc2xwLWFwcDoxMjM0NQ==", forHTTPHeaderField: "Authorization")
        urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}

