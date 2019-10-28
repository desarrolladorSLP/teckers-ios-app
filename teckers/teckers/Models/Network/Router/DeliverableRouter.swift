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
    case getDeliverablesParent
<<<<<<< HEAD
    case getOneDeliverableWith(_ id: String)
    case postDeliverable(id: String, text: String)
    
    var method: HTTPMethod {
        switch self {
            case .getDeliverables:
                return .get
            case .getOneDeliverableWith(_):
                return .get
            case .postDeliverable(_, _):
                return .post
    
            case .getDeliverables:
                return .get
            case .getDeliverablesParent:
                return .get
=======
    case getDeliverablesMentor
    
    var method: HTTPMethod {
        switch self {
        case .getDeliverables:
            return .get
        case .getDeliverablesParent:
            return .get
        case .getDeliverablesMentor:
            return .get
>>>>>>> Role Definition
        }
    }
    
    var path: String {
        switch self {
            case .getDeliverables:
                return "/api/tecker"
            case .getOneDeliverableWith(let id):
                return "/api/deliverable/\(id)"
            case .postDeliverable(let id,_):
                return "/api/deliverable/\(id)"
            case .getDeliverables:
                return "/api/deliverable"
            case .getDeliverablesParent:
                return "/api/parent/teckers"
            case .getDeliverablesMentor:
                return "/api/mentor/teckers"
        }
    }
    var parameters: [String: Any]? {
        switch self{
            case .postDeliverable(_, let text):
                return ["Deliverable": text]
            default:
                return nil
        
        }
    }
    
    func asURLRequest() throws -> URLRequest {
        let url = try RoadURL.baseURL.rawValue.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        let tokendictionary = Token()
        if let accessToken = try tokendictionary.getToken(user: TokenKeys.AccessToken.rawValue) {
            urlRequest.setValue("\(Header.Bearer.rawValue) \(accessToken)", forHTTPHeaderField: Header.Authorization.rawValue)
        }
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}
