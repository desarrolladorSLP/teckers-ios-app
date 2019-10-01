//
//  TypeNetworkErrors.swift
//  teckers
//
//  Created by Maggie Mendez on 9/30/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

enum TypesNetworkErrors : String {
    case badRequest = "400" //Status 400
    case unauthorized = "401" //Status 401
    case forbidden //Status 403
    case pageNotFound = "Pagina No Encontrada" //Status 404
    case requestTimeOut = "408" //Status 408
    
    case internalServerError = "500" //Status 500
    case serviceUnavaible = "503" //Status 503
    
    case noInternet = "Sin Internet"
    case noJSON
    case unknow = "Error Desconocido \n favor de comunicarte con el administrador"
}
