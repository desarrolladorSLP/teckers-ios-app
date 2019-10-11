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
    
    func getRange(status: NetworkAnswers) -> Range<Int>{
        switch status {
        case .ok:
            return 200..<400
        default:
            return -100..<0
        }
    }
}
