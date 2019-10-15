//
//  NetworkAnswers.swift
//  teckers
//
//  Created by Maggie Mendez on 11/10/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
enum NetworkAnswers: Int {
    
    case requestTimeOutXcode = 0
    case ok = 200
    case badRequest = 400
    case unauthorized = 401
    case forbidden = 403
    case pageNotFound =  404
    case requestTimeOut =  408
    case conflict = 409
    
    case internalServerError =  500
    
    case noInternet = 600
    
}
extension NetworkAnswers{
    init?(value: Int) {
        switch value {
        case ...0:
            self.init(rawValue: 0)
        case 201..<400:
            self.init(rawValue: 200)
        case 402, 405...407, 410..<500:
            self.init(rawValue: 400)
        case 500..<600:
            self.init(rawValue: 500)
        default:
            self.init(rawValue: value)
        }
    }
}
