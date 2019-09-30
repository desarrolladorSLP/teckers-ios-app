//
//  TypeNetworkErrors.swift
//  teckers
//
//  Created by Maggie Mendez on 9/30/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

enum TypesNetworkErrors : String {
    case badRequest = "400"
    case unauthorized = "401"
    case requestTimeOut = "408"
    case internalServerError = "500"
    case serviceUnavaible = "503"
    
    case noJSON
    case unknow
}
