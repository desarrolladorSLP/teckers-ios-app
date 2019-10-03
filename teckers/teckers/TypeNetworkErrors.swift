//
//  TypeNetworkErrors.swift
//  teckers
//
//  Created by Maggie Mendez on 9/30/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

enum TypesNetworkErrors : String {
    case badRequest = "Ha ocurrido un error, favor de comunicarte con el administrador" //Status 400
    case unauthorized = "Ha ocurrido un error.\n Vuelve a iniciar sesión o Intentalo más tarde. " //Status 401
    case forbidden = "No tienes permisos para acceder a este recurso."//Status 403
    case pageNotFound = "No se encontraron los datos, favor de comunicarte con el administrador" // Status 404
    case requestTimeOut = "Tiempo de espera agotado." // Status 408
    
    case internalServerError = "Error de Servidor." //Status 500
    
    case noInternet = "No es posible conectarse a una red."
    case noJSON = "Ha ocurrido un error en el formato de los datos, favor de comunicarte con el administrador."
    case unknow = "Error Desconocido, favor de comunicarte con el administrador."
}
