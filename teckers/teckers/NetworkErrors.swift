//
//  NetworkErrors.swift
//  teckers
//
//  Created by Maggie Mendez on 9/26/19.
//  Copyright © 2019 Teckers. All rights reserved.
//

import Foundation
import UIKit

class NetworkError{
    static let instance = NetworkError()
    
    private let messageErrors: [TypesNetworkErrors: (String, Int)]
    private let actionsBeforeAlert: [TypesNetworkErrors: () -> Void ]
    init() {
        messageErrors = [.badRequest : ("Oops, algo ah salido mal al solicitar los datos, contactate con el servicio al cliente de la app", 0),
                         .unknow : (TypesNetworkErrors.unknow.rawValue, 0),
                      .unauthorized : ("Tu cuanta expiro.\n Intenta volver a iniciar sesion", 0),
                      .forbidden: ("Acceso denegado No tiene permiso para acceder", 0),
                      .pageNotFound : (" Error 404 Esta pagina no funciona ", 0),
                      .requestTimeOut : ("Tiempo limite", 0),
                      .noInternet: (TypesNetworkErrors.noInternet.rawValue, 0)]
        self.actionsBeforeAlert = [.unauthorized: {
            if let topController = UIApplication.shared.keyWindow?.rootViewController{
                if let presentController = topController.presentedViewController {
                    presentController.dismiss(animated: true, completion: nil)
                }
            }
        }]
    }
    
    func getInformation( for statusCode: Int) ->  (String, Int)?{
        switch statusCode{
        case ..<0:
            return messageErrors[.noInternet]
        case 400:
            return messageErrors[.badRequest]
        case 401:
            return messageErrors[.unauthorized]
        case 404:
            return messageErrors[.pageNotFound]
        case 400..<500:
            return messageErrors[.unknow]
        case 500..<600:
            return messageErrors[.unknow]
        default:
            return messageErrors[.unknow]
        }
    }
    func getActionBeforeAlert( for statusCode: Int) ->  (() -> Void)?{
        switch statusCode{
        case 401:
            return actionsBeforeAlert[.unauthorized]
        default:
            return nil
        }
    }
    
    func getAction(for statusCode: Int) -> () -> Void {
        let informationAnswer = getInformation(for: statusCode)
        
        return { [weak self] in
            if let action = self?.getActionBeforeAlert(for: statusCode) {
                action()
            }
            guard let infoAlert = informationAnswer else { return }
            let alertAction = Alert(title: "Error", massage: infoAlert.0 , type: infoAlert.1)
            if let topController = UIApplication.shared.keyWindow?.rootViewController{
                if let presentController = topController.presentedViewController {
                    presentController.present(alertAction.show(), animated: true, completion: nil)
                }
            }
        }
    }
}
