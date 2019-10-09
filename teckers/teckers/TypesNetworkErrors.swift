//
//  TypesNetworkErrors.swift
//  teckers
//
//  Created by Maggie Mendez on 10/9/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

enum TypesNetworkErrors : String {
    case badRequest = "Favor de comunicarte con el administrador" //Status 400
    case unauthorized = "Vuelve a iniciar sesión o Intentalo más tarde. " //Status 401
    case forbidden = "No tienes permisos para acceder a este recurso."//Status 403
    case pageNotFound = "No se encontraron los datos, favor de comunicarte con el administrador" // Status 404
    case requestTimeOut = "Tiempo de espera agotado." // Status 408
    
    case internalServerError = "Problema de Servidor." //Status 500
    
    case noInternet = "No es posible conectarse a una red."
    case noJSON = "El formato de los datos ha sido incorrecto, favor de comunicarse con el administrador."
    case unknow = "Problema Desconocido, favor de comunicarse con el administrador."
}
