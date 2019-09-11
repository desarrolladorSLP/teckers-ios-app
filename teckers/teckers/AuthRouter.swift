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
    
    case getMessages
    
    var method: HTTPMethod {
        switch self {
        case .auth:
            return .post
        case .getMessages:
            return .get
        }
    }
    
    var parameters: [String: Any] {
        var parameters: [String: Any] = [:]
        switch self {
        case .auth(let token):
            parameters = ["grant_type": "firebase", "firebase-token-id": token]
        case .getMessages:
            parameters = [:]
        }
        return parameters
    }
    
    var path: String {
        switch self {
        case .auth:
            return "/oauth/token"
        case .getMessages:
            return "/api/messages"
        }
    }
     
    func asURLRequest() throws -> URLRequest {
        let url = try RoadURL.baseURL.rawValue.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        switch self {
        case .auth(token: _):
            if let path = Bundle.main.url(forResource: "InfoApplication", withExtension: "plist") {
                do {
                    let dataPlist = try Data(contentsOf: path)
                    let pListData = try PropertyListSerialization.propertyList(from: dataPlist, options: [], format: nil) as! [String:Any]
                    let username = pListData["USER"] as! String
                    let password = pListData["PASSWORD"] as! String
                    let loginString = String(format: "%@:%@", username, password)
                    let loginData = loginString.data(using: String.Encoding.utf8)!
                    let base64LoginString = loginData.base64EncodedString()
                    urlRequest.httpMethod = method.rawValue
                    urlRequest.setValue("Basic \(base64LoginString)", forHTTPHeaderField: "Authorization")
                    urlRequest.setValue("application/json", forHTTPHeaderField: "Accept")
                } catch {
                    return error as! URLRequest
                }
            }
        case .getMessages:
            urlRequest = URLRequest(url: url.appendingPathComponent(path))
        }
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}

