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

    var method: HTTPMethod {
        switch self {
        case .auth:
            return .post
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .auth(let token):
            return ["grant_type": "firebase", "firebase_token_id": token]
        }
    }
    
    var path: String {
        switch self {
        case .auth:
            return "/oauth/token"
        }
    }
     
    func asURLRequest() throws -> URLRequest {
        let url = try RoadURL.baseURL.rawValue.asURL()
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        let authorizationHeader = "Authorization"
        let acceptHeader = "Accept"

        if let path = Bundle.main.url(forResource: "InfoApplication", withExtension: "plist") {
            do {
                let dataPlist = try Data(contentsOf: path)
                let pListData = try PropertyListSerialization.propertyList(from: dataPlist, options: [], format: nil) as! [String:Any]
                let username = pListData[InfoApplicationKeys.USER.rawValue] ?? ""
                let password = pListData[InfoApplicationKeys.PASSWORD.rawValue] ?? ""
                let loginString = "\(username):\(password)"
                let loginData = loginString.data(using: String.Encoding.utf8)!
                let base64LoginString = loginData.base64EncodedString()
                urlRequest.httpMethod = method.rawValue
                urlRequest.setValue(Header.Basic.rawValue + String(base64LoginString), forHTTPHeaderField: authorizationHeader)
                urlRequest.setValue(Header.Accept.rawValue, forHTTPHeaderField: acceptHeader)
            } 
        }
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}

