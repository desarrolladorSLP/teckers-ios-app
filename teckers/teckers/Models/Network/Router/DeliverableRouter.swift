//
//  DeliverableRouter.swift
//  teckers
//
//  Created by Maggie Mendez on 15/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import Alamofire

enum DeliverableRouter: URLRequestConvertible {
    
    case getDeliverables
    case getDeliverablesId(teckerId: String)
    case getDeliverablesParent
    case getDeliverablesMentor
    
    var method: HTTPMethod {
        switch self {
        case .getDeliverables:
            return .get
        case .getDeliverablesId(_):
            return .get
        case .getDeliverablesParent:
            return .get
        case .getDeliverablesMentor:
            return .get
        }
    }
    
    var path: String {
        switch self {
        case .getDeliverables:
            return "/api/tecker/deliverables"
        case .getDeliverablesId(let teckerId):
            return "/api/tecker/\(teckerId)/deliverables"
        case .getDeliverablesParent:
            return "/api/parent/teckers"
        case .getDeliverablesMentor:
            return "/api/mentor/teckers"
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try RoadURL.baseURL.rawValue.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        let tokendictionary = Token()
        if let accessToken = try tokendictionary.getToken(user: TokenKeys.AccessToken.rawValue) {
            urlRequest.setValue("\(Header.Bearer.rawValue) \(accessToken)", forHTTPHeaderField: Header.Authorization.rawValue)
        }
        
        return try URLEncoding.default.encode(urlRequest, with: nil)
    }
}
