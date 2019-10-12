//
//  TypesNetworkErrors.swift
//  teckers
//
//  Created by Maggie Mendez on 10/9/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation

enum TypesNetworkErrors : String {
    case badRequest = "Hubo un problema con la red \nIntenta más tarde"
    case unauthorized = "Vuelve a iniciar sesión o Intentalo más tarde. "
    case forbidden = "No tienes permisos para acceder a este recurso."
    case pageNotFound = "No se encontraron los datos. \nIntenta más tarde."
    case requestTimeOut = "Tiempo de espera agotado."
    
    case internalServerError = "Problema de Servidor." 
    
    case noInternet = "No es posible conectarse a una red."
    case noJSON = "El formato de los datos ha sido incorrecto."
    case unknow = "Problema Desconocido."

}
