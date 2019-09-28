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
        let fileName = "InfoApplication"
        let fileExtension = "plist"
        let account = (user: "USER",password: "PASSWORD")
        
        urlRequest.httpMethod = method.rawValue
        if let path = Bundle.main.url(forResource: fileName, withExtension: fileExtension) {
            do {
                let dataPlist = try Data(contentsOf: path)
                let pListData = try PropertyListSerialization.propertyList(from: dataPlist, options: [], format: nil) as? [String:Any]
                let username = pListData?[account.user] ?? ""
                let password = pListData?[account.password] ?? ""
                let loginString = "\(username):\(password)"
                let loginData = loginString.data(using: String.Encoding.utf8) ?? nil
                let base64LoginString = loginData?.base64EncodedString() ?? ""
                let authorizationHeader = "Authorization"
                let acceptHeader = "Accept"
                
                urlRequest.setValue(Header.Authorization.rawValue + String(base64LoginString), forHTTPHeaderField: authorizationHeader)
                urlRequest.setValue(Header.Accept.rawValue, forHTTPHeaderField: acceptHeader)
            } catch {
                return error as! URLRequest
            }
        }
        
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
}

